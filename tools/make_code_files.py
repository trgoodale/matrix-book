#!/usr/bin/env python3
"""Generate a Jupyter notebook and a MATLAB script for each chapter.

The book's code lives in the chapters, in Python/MATLAB tabs. This script
copies it out, with the text around it, so readers can run and change it:

    code/python/NN-name.ipynb      one notebook per chapter (Python)
    code/matlab/chNN_name.m        one script per chapter (MATLAB)
    code/python/part-N-review.ipynb, code/matlab/partN_review.m
                                   the code exercises of each part review
    code/python/solutions-part-N.ipynb, code/matlab/solutions_partN.m
                                   worked solutions to the code exercises

Run it from the book's root folder after rendering the book once (it reads
_book/ to find the numbers Quarto gives figures, equations and chapters):

    python3 tools/make_code_files.py            # all chapters
    python3 tools/make_code_files.py part-1/01-matrices.qmd
    python3 tools/make_code_files.py --check    # report out-of-date files

With --check nothing is written: it lists any file in code/ that differs
from what the chapters would give (ignoring line endings) and exits with
status 1 if there are any. The GitHub workflow check-code.yml runs this.

The notebooks are saved without outputs; run them to see the results.
"""
import glob
import html as htmllib
import json
import os
import re
import sys
import textwrap

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = "https://trgoodale.github.io/matrix-book/"
REPO = "trgoodale/matrix-book"
BRANCH = "main"
RAW_DATA = f"https://raw.githubusercontent.com/{REPO}/{BRANCH}/data/"
PY_DIR = "code/python"
ML_DIR = "code/matlab"

# --------------------------------------------------------------------------
# Cross-references: read the labels Quarto gave them from the rendered book.
# --------------------------------------------------------------------------
XREF = {}   # id -> (label text, page path relative to the site)
PAGE_LABEL = {}   # page path -> label of a link to the whole page ("Chapter 24")


def load_xrefs():
    for path in sorted(glob.glob(os.path.join(ROOT, "_book", "**", "*.html"), recursive=True)):
        rel = os.path.relpath(path, os.path.join(ROOT, "_book"))
        txt = open(path, encoding="utf-8").read()
        for m in re.finditer(r'<a href="([^"#]*)#((?:sec|fig|eq|tbl|ex)-[\w-]+)"[^>]*class="quarto-xref"[^>]*>(.*?)</a>', txt, re.S):
            target, ident, label = m.groups()
            label = htmllib.unescape(re.sub(r"<[^>]+>", "", label)).strip()
            page = os.path.normpath(os.path.join(os.path.dirname(rel), target)) if target else rel
            if ident not in XREF and label:
                XREF[ident] = (label, page.replace(os.sep, "/"))
        # links to whole chapters have no fragment: remember each page's label
        for m in re.finditer(r'<a href="([^"#]+\.html)"[^>]*class="quarto-xref"[^>]*>(.*?)</a>', txt, re.S):
            target, label = m.groups()
            label = htmllib.unescape(re.sub(r"<[^>]+>", "", label)).strip()
            page = os.path.normpath(os.path.join(os.path.dirname(rel), target)).replace(os.sep, "/")
            # some links (the glossary's) show the full title, "1  What is a matrix?"
            label = re.sub(r"^(\d+)\s.*", r"Chapter \1", label, flags=re.S)
            if label:
                PAGE_LABEL.setdefault(page, label)
    # chapter headings that are never cross-referenced still need a page
    for qmd in sorted(glob.glob(os.path.join(ROOT, "*", "*.qmd"))):
        m = re.search(r"^# .*\{#(sec-[\w-]+)", open(qmd, encoding="utf-8").read(), re.M)
        if m:
            rel = os.path.relpath(qmd, ROOT)[:-4] + ".html"
            XREF[m.group(1)] = (PAGE_LABEL.get(rel), rel)


def ref_link(ident, md=True):
    label, page = XREF.get(ident, (None, None))
    if page is None:
        return ident
    if label is None:
        label = "the chapter"
    url = SITE + page + ("" if ident.startswith("sec-") and "#" not in page else "#" + ident)
    return f"[{label}]({url})" if md else label


# --------------------------------------------------------------------------
# Text conversion
# --------------------------------------------------------------------------
def brace_arg(s, i):
    """s[i] is '{'; return (content, index after the closing brace)."""
    depth = 0
    for j in range(i, len(s)):
        if s[j] == "{":
            depth += 1
        elif s[j] == "}":
            depth -= 1
            if depth == 0:
                return s[i + 1:j], j + 1
    return s[i + 1:], len(s)


def expand_macros(tex):
    """Replace the book's notation macros with standard LaTeX (default notation)."""
    out, i = [], 0
    while i < len(tex):
        m = re.match(r"\\(vect|M|ue|mat|amat|ui|uj|uk|T|R|zerovec)(?![A-Za-z])", tex[i:])
        if not m:
            out.append(tex[i]); i += 1; continue
        name = m.group(1); j = i + m.end()
        while j < len(tex) and tex[j] == " " and name in ("vect", "M", "ue", "mat", "amat"):
            j += 1
        if name in ("vect", "M", "ue", "mat") and j < len(tex) and tex[j] == "{":
            arg, j = brace_arg(tex, j); arg = expand_macros(arg)
            out.append({"vect": r"\mathbf{%s}", "M": r"\mathbf{%s}", "ue": r"\mathbf{e}_{%s}",
                        "mat": r"\begin{pmatrix}%s\end{pmatrix}"}[name] % arg)
        elif name == "amat" and j < len(tex) and tex[j] == "{":
            spec, j = brace_arg(tex, j)
            body, j = brace_arg(tex, j)
            out.append(r"\left(\begin{array}{%s}%s\end{array}\right)" % (spec, expand_macros(body)))
        else:
            out.append({"ui": r"\mathbf{i}", "uj": r"\mathbf{j}", "uk": r"\mathbf{k}", "T": r"^{\mathsf{T}}",
                        "R": r"\mathbb{R}", "zerovec": r"\mathbf{0}"}.get(name, "\\" + name))
        i = j
    return "".join(out)


def clean_markdown(text):
    """Quarto markdown -> plain Jupyter markdown."""
    t = text
    t = re.sub(r"\[\]\{#[^}]*\}", "", t)                                  # anchors
    t = re.sub(r"\[†\]\{[^}]*\}\[Harder exercise\.\]\{[^}]*\}\s*", "(Harder) ", t)
    t = re.sub(r"\{(?:target|aria-label|\.)[^}]*\}", "", t)              # link attributes
    t = re.sub(r"\[([^\]]*)\]\{\.[^}]*\}", r"\1", t)                      # [text]{.class}
    # internal links to other pages of the book
    def fix_link(m):
        text, url = m.group(1), m.group(2)
        if re.match(r"https?:", url):
            return m.group(0)
        url = re.sub(r"^(\.\./)+", "", url)
        url = re.sub(r"\.qmd", ".html", url)
        return f"[{text}]({SITE}{url})"
    t = re.sub(r"\[([^\]]*)\]\(([^)\s]+)\)", fix_link, t)
    t = re.sub(r"@((?:sec|fig|eq|tbl|ex)-[\w-]+)", lambda m: ref_link(m.group(1)), t)
    # maths: expand macros inside $...$ and $$...$$
    t = re.sub(r"\$\$(.*?)\$\$", lambda m: "$$" + expand_macros(m.group(1)) + "$$", t, flags=re.S)
    t = re.sub(r"(?<!\$)\$([^$\n]+)\$", lambda m: "$" + expand_macros(m.group(1)) + "$", t)
    t = re.sub(r"\$\$ \{#eq-[\w-]+\}", "$$", t)
    return t.strip()


GREEK = {"alpha": "α", "beta": "β", "gamma": "γ", "delta": "δ", "epsilon": "ε", "theta": "θ", "lambda": "λ",
         "mu": "μ", "pi": "π", "rho": "ρ", "sigma": "σ", "tau": "τ", "phi": "φ", "varphi": "φ", "omega": "ω",
         "Omega": "Ω", "kappa": "κ", "Delta": "Δ", "Sigma": "Σ", "Lambda": "Λ", "psi": "ψ", "hbar": "ħ"}
SYMBOLS = {"times": "×", "cdot": "·", "le": "≤", "leq": "≤", "ge": "≥", "geq": "≥", "neq": "≠", "ne": "≠",
           "approx": "≈", "to": "→", "infty": "∞", "pm": "±", "mp": "∓", "dots": "...", "ldots": "...",
           "cdots": "...", "in": "in", "equiv": "≡", "circ": "°", "partial": "∂", "nabla": "∇",
           "leftarrow": "<-", "rightarrow": "->", "mid": "|", "quad": "  ", "qquad": "   "}


BINARY = {"times", "cdot", "le", "leq", "ge", "geq", "neq", "ne", "approx", "to", "pm", "mp", "in", "equiv",
          "leftarrow", "rightarrow", "mid"}


def tex_to_plain(tex):
    """Rough LaTeX -> readable plain text, for MATLAB comments."""
    s = tex
    def mat(m_body):
        rows = [r.strip() for r in re.split(r"\\\\", m_body) if r.strip()]
        return "[" + "; ".join(" ".join(c.strip() for c in r.split("&")) for r in rows) + "]"
    # matrices first: rows split by \\, entries by &
    s = re.sub(r"\\left[(\[]|\\right[)\]]", "", s)
    s = re.sub(r"\\begin\{(pmatrix|bmatrix|matrix|array)\}(\{[^}]*\})?(.*?)\\end\{\1\}",
               lambda m: mat(tex_to_plain(m.group(3).replace("|", "&")) if "\\begin" in m.group(3) else m.group(3)), s, flags=re.S)
    out, i = [], 0
    while i < len(s):
        m = re.match(r"\\([A-Za-z]+)", s[i:])
        if not m:
            c = s[i]
            out.append("" if c in "{}" else c); i += 1; continue
        name = m.group(1); j = i + m.end()
        while j < len(s) and s[j] == " " and name not in ("rvert", "rVert", "right"):
            j += 1                                  # TeX ignores spaces after a control word
        def arg(j):
            while j < len(s) and s[j] == " ":
                j += 1
            if j < len(s) and s[j] == "{":
                return brace_arg(s, j)
            return (s[j] if j < len(s) else ""), j + 1
        if name in ("vect", "M", "mathbf", "mathrm", "text", "textbf", "operatorname", "mathsf", "boldsymbol", "mathbb", "underline", "vec", "hat"):
            a, j = arg(j); out.append(tex_to_plain(a) if name != "mathbb" else {"R": "R"}.get(a, a))
        elif name == "mat":
            a, j = arg(j); out.append(mat(tex_to_plain(a)))
        elif name == "amat":
            _, j = arg(j); a, j = arg(j); out.append(mat(tex_to_plain(a.replace("|", "&"))))
        elif name in ("frac", "tfrac", "dfrac"):
            a, j = arg(j); b, j = arg(j)
            a, b = tex_to_plain(a), tex_to_plain(b)
            wrap = lambda x: x if re.fullmatch(r"[\w.]+(\([^()]*\))?", x) else "(" + x + ")"
            out.append("(" + wrap(a) + "/" + wrap(b) + ")")
        elif name == "sqrt":
            a, j = arg(j); out.append("sqrt(" + tex_to_plain(a) + ")")
        elif name == "ue":
            a, j = arg(j); out.append("e" + tex_to_plain(a))
        elif name == "T":
            out.append("'")
        elif name == "zerovec":
            out.append("0")
        elif name in ("R",):
            out.append("R")
        elif name in ("lVert", "rVert", "Vert"):
            out.append("||")
        elif name in ("lvert", "rvert", "vert"):
            out.append("|")
        elif name in ("left", "right", "big", "Big", "bigl", "bigr", "Bigl", "Bigr", "bigg", "displaystyle", "limits"):
            pass
        elif name in ("begin", "end"):
            a, j = arg(j)
        elif name in GREEK:
            out.append(GREEK[name])
        elif name in SYMBOLS:
            sym = SYMBOLS[name]
            out.append(" " + sym + " " if name in BINARY else sym)
        else:
            out.append(name)
        i = j
    s = "".join(out)
    s = s.replace("\\,", " ").replace("\\;", " ").replace("\\!", "").replace("\\ ", " ")
    s = re.sub(r"\^T(?=[A-Za-z(])", "^T ", s)
    return re.sub(r"[ \t]+", " ", s)


def to_plain(md):
    """Markdown with maths -> plain text for MATLAB comments."""
    t = clean_markdown(md)
    t = re.sub(r"\$\$(.*?)\$\$", lambda m: " " + tex_to_plain(m.group(1)).strip() + " ", t, flags=re.S)
    t = re.sub(r"\$([^$]+)\$", lambda m: tex_to_plain(m.group(1)), t)
    t = re.sub(r"\[([^\]]*)\]\((https?://[^)]+)\)", lambda m: m.group(1), t)
    t = re.sub(r"\*\*([^*]+)\*\*", r"\1", t)
    t = re.sub(r"(?<!\*)\*([^*\n]+)\*(?!\*)", r"\1", t)
    t = t.replace("`", "")
    return t


def comment(text, width=76):
    lines = []
    for para in to_plain(text).split("\n"):
        para = para.strip()
        if not para:
            lines.append("%")
            continue
        bullet = re.match(r"^([-*]|\d+\.)\s+", para)
        lines += ["% " + l for l in textwrap.wrap(para, width - 2, subsequent_indent="  " if bullet else "")]
    while lines and lines[-1] == "%":
        lines.pop()
    return "\n".join(lines)


# --------------------------------------------------------------------------
# Parsing the chapters
# --------------------------------------------------------------------------
def read_qmd(path):
    """Read a chapter, leaving out the links to these code files."""
    txt = open(path, encoding="utf-8").read()
    return re.sub(r"(?ms)^[ \t]*::: \{\.code-files\}\n.*?^[ \t]*:::[ \t]*\n\n?", "", txt)


def chapter_info(path):
    txt = read_qmd(path)
    m = re.search(r"^# (.*?)\s*\{#(sec-[\w-]+)", txt, re.M)
    return txt, m.group(1).strip(), m.group(2)


def split_fences(lines):
    """Yield ('code', lang, opts, body) and ('text', None, None, text) items for a tab."""
    items, buf, i = [], [], 0
    while i < len(lines):
        l = lines[i]
        m = re.match(r"^```\s*(\{python\}|matlab|\{\.text \.code-output\}|python)\s*$", l)
        if m:
            if buf:
                items.append(("text", None, None, "\n".join(buf))); buf = []
            j = i + 1
            while not lines[j].startswith("```"):
                j += 1
            body = lines[i + 1:j]
            lang = {"{python}": "python", "python": "python", "matlab": "matlab"}.get(m.group(1), "output")
            opts = [b for b in body if b.startswith("#|")]
            body = [b for b in body if not b.startswith("#|")]
            items.append(("code", lang, opts, "\n".join(body).strip("\n")))
            i = j + 1
            continue
        buf.append(l); i += 1
    if buf and "\n".join(buf).strip():
        items.append(("text", None, None, "\n".join(buf)))
    return items


def parse_tabsets(txt):
    """Find the code in a chapter.

    Returns a list of blocks. Each block has the section heading it is under,
    the text before it, and the Python and MATLAB items of the tabset.
    A figure's folded code (outside any tabset) is returned with matlab=None.
    """
    lines = txt.split("\n")
    blocks, heading, sub, lead = [], None, None, []
    i = 0
    while i < len(lines):
        l = lines[i]
        hm = re.match(r"^(##|###) (.*?)(\s*\{.*\})?$", l)
        if hm and not l.startswith("####"):
            if hm.group(1) == "##":
                heading, sub = hm.group(2), None
            else:
                sub = hm.group(2)
            lead = []
            i += 1; continue
        if re.match(r"^:::+ \{\.panel-tabset group=\"language\"\}", l):
            # collect the tabset to its closing fence
            fence = re.match(r"^(:+)", l).group(1)
            j = i + 1; depth = 1
            while j < len(lines):
                if re.match(r"^:{3,}\s*\{", lines[j]) or re.match(r"^:{3,}\s+\S", lines[j]):
                    depth += 1
                elif re.match(r"^:{3,}\s*$", lines[j]):
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            body = lines[i + 1:j]
            tabs, cur = {}, None
            for b in body:
                tm = re.match(r"^## (Python|MATLAB)\s*$", b)
                if tm:
                    cur = tm.group(1); tabs[cur] = []; continue
                if cur:
                    tabs[cur].append(b)
            blocks.append({"heading": heading, "sub": sub, "lead": "\n".join(lead).strip(),
                           "python": split_fences(tabs.get("Python", [])),
                           "matlab": split_fences(tabs.get("MATLAB", []))})
            lead = []
            i = j + 1; continue
        if l.startswith("```{python}"):
            j = i + 1
            while not lines[j].startswith("```"):
                j += 1
            body = lines[i + 1:j]
            opts = [b for b in body if b.startswith("#|")]
            code = "\n".join(b for b in body if not b.startswith("#|")).strip("\n")
            if not any("echo: false" in o or "include: false" in o for o in opts):
                label = next((re.sub(r"#\|\s*label:\s*", "", o) for o in opts if "label:" in o), None)
                blocks.append({"heading": heading, "sub": sub, "lead": "", "figure": label,
                               "python": [("code", "python", opts, code)], "matlab": None})
            i = j + 1; continue
        if l.strip() and not l.startswith(":::") and not l.startswith("!["):
            lead.append(l)
        elif not l.strip():
            lead.append("")
        i += 1
    return blocks


def code_exercises(txt):
    """The code exercises of a chapter or review: list of (number, text)."""
    out = []
    m = re.search(r"^## Exercises.*?$(.*?)(?=^## )", txt, re.M | re.S)
    sec = m.group(1) if m else txt
    items = re.split(r"(?m)^(?=\d+\. )", sec)
    for it in items:
        mm = re.match(r"(\d+)\. ", it)
        if mm and "**Code.**" in it:
            body = re.sub(r"^\d+\.\s*", "", it.strip())
            body = re.sub(r"(?m)^   ", "", body)                    # list indentation
            body = body.split("\n\nSolutions are in")[0]
            body = re.sub(r"\*\*Code\.\*\*\s*", "", body)
            body = re.sub(r"\n*\[Solution to exercise[^\n]*", "", body)
            out.append((int(mm.group(1)), body.strip()))
    return out


def solution_code(sol_txt, key):
    """Python and MATLAB items of the solution to exercise `key`, plus the text after them."""
    m = re.search(r"\{#solution-%s\}(.*?)(?=\n\[\*\*\d+\.\*\*\]\{#solution-|\n## (?!Python|MATLAB)|\Z)" % re.escape(key), sol_txt, re.S)
    if not m:
        return None
    body = m.group(1)
    body = re.sub(r"\[Back to exercise[^\n]*", "", body)
    tm = re.search(r":::+ \{\.panel-tabset group=\"language\"\}\n(.*?)\n:::+\s*\n", body, re.S)
    if not tm:
        # Python only in the book; the MATLAB version is kept in tools/matlab_solutions
        items = split_fences(body.split("\n"))
        codes = [k for k, it in enumerate(items) if it[0] == "code" and it[1] == "python"]
        if not codes:
            return None
        before = "\n".join(it[3] for it in items[:codes[0]] if it[0] == "text").strip()
        after = "\n".join(it[3] for it in items[codes[-1] + 1:] if it[0] == "text").strip()
        python = items[codes[0]:codes[-1] + 1]
        extra = os.path.join(ROOT, "tools", "matlab_solutions", key + ".m")
        matlab = []
        if os.path.exists(extra):
            code = open(extra, encoding="utf-8").read()
            fextra = extra[:-2] + ".functions.m"
            if os.path.exists(fextra):
                code += "\n" + open(fextra, encoding="utf-8").read()
            matlab = [("text", None, None, "The book gives this solution in Python. Here is a MATLAB version."),
                      ("code", "matlab", [], code.strip())]
        return {"before": before, "after": after, "python": python, "matlab": matlab}
    tabs, cur = {}, None
    for b in tm.group(1).split("\n"):
        t2 = re.match(r"^## (Python|MATLAB)\s*$", b)
        if t2:
            cur = t2.group(1); tabs[cur] = []; continue
        if cur:
            tabs[cur].append(b)
    before = body[:tm.start()].strip()
    after = body[tm.end():].strip()
    return {"before": before, "after": after,
            "python": split_fences(tabs.get("Python", [])), "matlab": split_fences(tabs.get("MATLAB", []))}


# --------------------------------------------------------------------------
# Writers
# --------------------------------------------------------------------------
def md_cell(src):
    return {"cell_type": "markdown", "metadata": {}, "source": src.strip("\n").splitlines(True)}


def code_cell(src):
    return {"cell_type": "code", "execution_count": None, "metadata": {}, "outputs": [],
            "source": src.strip("\n").splitlines(True)}


def notebook(cells):
    # nbformat 4.5 needs an id on each cell; numbering them keeps the files stable
    cells = [{"id": f"cell-{k}", **cell} for k, cell in enumerate(cells, 1)]
    return {"cells": cells, "metadata": {
        "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
        "language_info": {"name": "python"}}, "nbformat": 4, "nbformat_minor": 5}


DATA_SETUP_PY = f'''# The data files are in the book's repository. Use the local copy if there is one,
# otherwise read them from GitHub (as in Colab).
import os
DATA = "../../data/" if os.path.exists("../../data/iris.csv") else "{RAW_DATA}"'''

DATA_SETUP_ML = f'''% The data files are in the book's repository. Use the local copy if there is
% one, otherwise read them from GitHub.
if isfile(fullfile('..', '..', 'data', 'iris.csv'))
    DATA = fullfile('..', '..', 'data');
else
    DATA = '{RAW_DATA.rstrip("/")}';
end'''


def py_fix(code):
    return re.sub(r"(['\"])\.\./data/([\w.-]+)\1", r'DATA + "\2"', code)


def ml_fix(code):
    code = re.sub(r"(['\"])\.\./data/([\w.-]+)\1", r"[DATA '/\2']", code)
    return code


def colab_url(nb_name):
    return f"https://colab.research.google.com/github/{REPO}/blob/{BRANCH}/{PY_DIR}/{nb_name}"


def header_md(title, page_url, nb_name, what):
    return (f"# {title}\n\n"
            f"{what} from [*Matrices in Practice*]({page_url}), by Tom Goodale.\n\n"
            f"[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)]({colab_url(nb_name)})\n\n"
            "Run the cells in order, from the top: later cells use variables set in earlier ones. "
            "Change the numbers and run them again to see what happens. "
            "The code needs NumPy, SciPy and Matplotlib (and pandas in a few chapters), all of which Colab already has.\n\n"
            "Code licensed under the [MIT licence](" + SITE + "LICENSE.md).")


def ml_header(title, page_url, what, script):
    bar = "%" * 76
    return (f"{bar}\n%% {title}\n{bar}\n"
            f"% {what} from Matrices in Practice, by Tom Goodale:\n% {page_url}\n%\n"
            f"% Run the script a section at a time (Run Section, or Ctrl+Enter, in\n"
            f"% MATLAB), from the top: later sections use variables set in earlier ones.\n"
            f"% Change the numbers and run them again to see what happens.\n%\n"
            f"% Code licensed under the MIT licence: {SITE}LICENSE.md\n")


def split_functions(code):
    """Separate MATLAB function definitions (which must come last in a script)."""
    lines, main, funcs, i = code.split("\n"), [], [], 0
    while i < len(lines):
        if lines[i].startswith("function "):
            # find the matching end, counting the blocks opened inside the function
            depth, j = 1, i + 1
            while j < len(lines) and depth:
                code = re.sub(r"%.*|'[^']*'", "", lines[j]).strip()
                depth += len(re.findall(r"^(for|if|while|switch|try|parfor)\b", code))
                depth -= len(re.findall(r"(?:^|[;,]\s*)end\b\s*;?\s*$", code))
                j += 1
            funcs.append("\n".join(lines[i:j]).rstrip()); i = j
            continue
        main.append(lines[i]); i += 1
    return "\n".join(main).strip("\n"), funcs


def unique_functions(funcs):
    """Keep the first definition of each function name."""
    seen, out = set(), []
    for f in funcs:
        name = re.match(r"function\s+(?:\[?[^=]*\]?\s*=\s*)?(\w+)", f).group(1)
        if name not in seen:
            seen.add(name); out.append(f)
    return out


def section_title(block):
    h = block["heading"] or ""
    return h if not block["sub"] else f"{h}: {block['sub']}" if h else block["sub"]


def build_chapter(qmd):
    txt, title, sec = chapter_info(os.path.join(ROOT, qmd))
    base = os.path.basename(qmd)[:-4]                    # 01-matrices
    num = base.split("-")[0]
    nb_name = f"{base}.ipynb"
    ml_name = f"ch{num}_{base.split('-', 1)[1].replace('-', '_')}.m"
    page = SITE + qmd[:-4] + ".html"
    label = XREF.get(sec, ("Chapter " + str(int(num)), None))[0] or "Chapter " + str(int(num))
    blocks = parse_tabsets(txt)
    uses_data = "../data/" in txt

    cells = [md_cell(header_md(f"{label}: {title}", page, nb_name, "The code for this chapter"))]
    ml = [ml_header(f"{label}: {title}", page, "The code for this chapter", ml_name)]
    funcs = []
    if uses_data:
        cells.append(code_cell(DATA_SETUP_PY))
        ml.append("%% Data\n" + DATA_SETUP_ML + "\n")
    last = None
    for b in blocks:
        sect = section_title(b)
        if b.get("figure") is not None or b["matlab"] is None:
            fig = b.get("figure")
            flab = XREF.get(fig, (None,))[0] if fig else None
            cells.append(md_cell(f"### Code for {flab or 'a figure'}\n\nThis draws "
                                 + (f"[{flab}]({page}#{fig})" if flab else "a figure")
                                 + " in the chapter. You don't need it for the rest of the notebook."))
            cells.append(code_cell(py_fix(b["python"][0][3])))
            continue
        if sect != last:
            cells.append(md_cell(f"## {sect}" + ("\n\n" + clean_markdown(b["lead"]) if b["lead"] else "")))
            ml.append(f"%% {to_plain(sect)}" + ("\n" + comment(b["lead"]) if b["lead"] else "") + "\n")
            last = sect
        elif b["lead"]:
            cells.append(md_cell(clean_markdown(b["lead"])))
            ml.append("%%\n" + comment(b["lead"]) + "\n")
        for kind, lang, opts, body in b["python"]:
            if kind == "text":
                if body.strip():
                    cells.append(md_cell(clean_markdown(body)))
            elif lang == "python":
                cells.append(code_cell(py_fix(body)))
        first = True
        for kind, lang, opts, body in b["matlab"]:
            if kind == "text":
                if body.strip():
                    ml.append(("" if first else "%%\n") + comment(body) + "\n")
            elif lang == "matlab":
                main, fs = split_functions(ml_fix(body))
                funcs += fs
                if main:
                    ml.append(main + "\n")
                first = False

    exercises = code_exercises(txt)
    if exercises:
        cells.append(md_cell(f"## Exercises\n\nThe code exercises from the [end of the chapter]({page}#sec-{sec[4:]}-exercises). "
                             f"Worked solutions are in the notebook `solutions-part-{qmd[5]}.ipynb`, "
                             f"and in the [book's solutions]({SITE}appendices/solutions-{qmd[5]}.html#sec-solutions-{sec[4:]})."))
        ml.append(f"%% Exercises\n% The code exercises from the end of the chapter. Worked solutions are in\n"
                  f"% solutions_part{qmd[5]}.m, and in the book:\n% {SITE}appendices/solutions-{qmd[5]}.html#sec-solutions-{sec[4:]}\n")
        for n, body in exercises:
            cells.append(md_cell(f"### Exercise {n}\n\n" + clean_markdown(body)))
            cells.append(code_cell("# Your code here"))
            ml.append(f"%% Exercise {n}\n" + comment(body) + "\n\n% Your code here\n")
    if funcs:
        ml.append("%% Functions\n% MATLAB needs the functions used in a script to come at its end.\n\n" + "\n\n".join(unique_functions(funcs)) + "\n")
    return nb_name, notebook(cells), ml_name, "\n".join(ml)


PART_NAMES = {}


def part_name(n):
    if not PART_NAMES:
        for m in re.finditer(r'- part: "(Part [IVX]+: [^"]+)"', open(os.path.join(ROOT, "_quarto.yml"), encoding="utf-8").read()):
            PART_NAMES[len(PART_NAMES) + 1] = m.group(1)
    return PART_NAMES.get(n, f"Part {n}")


def roman(n):
    return ["", "I", "II", "III", "IV", "V", "VI"][n]


def add_solution(cells, ml, funcs, sol):
    if sol["before"]:
        cells.append(md_cell(clean_markdown(sol["before"])))
        ml.append(comment(sol["before"]) + "\n")
    for kind, lang, opts, body in sol["python"]:
        if kind == "text" and body.strip():
            cells.append(md_cell(clean_markdown(body)))
        elif lang == "python":
            cells.append(code_cell(py_fix(body)))
    for kind, lang, opts, body in sol["matlab"]:
        if kind == "text" and body.strip():
            ml.append(comment(body) + "\n")
        elif lang == "matlab":
            main, fs = split_functions(ml_fix(body))
            funcs += fs
            if main:
                ml.append(main + "\n")
    if sol["after"]:
        cells.append(md_cell(clean_markdown(sol["after"])))
        ml.append(comment(sol["after"]) + "\n")


def build_part(n):
    """The part's review exercises, and the solutions notebook for the part."""
    review_qmd = f"part-{n}/review.qmd"
    rtxt = read_qmd(os.path.join(ROOT, review_qmd))
    rpage = SITE + review_qmd[:-4] + ".html"
    soltxt = read_qmd(os.path.join(ROOT, f"appendices/solutions-{n}.qmd"))
    solpage = SITE + f"appendices/solutions-{n}.html"
    pname = part_name(n)

    # review exercises
    nb_name, ml_name = f"part-{n}-review.ipynb", f"part{n}_review.m"
    rex = code_exercises(rtxt)
    cells = [md_cell(header_md(f"{pname}: review", rpage, nb_name, "The code exercises of the part review"))]
    ml = [ml_header(f"{pname}: review", rpage, "The code exercises of the part review", ml_name)]
    if "../data/" in rtxt:
        cells.append(code_cell(DATA_SETUP_PY)); ml.append("%% Data\n" + DATA_SETUP_ML + "\n")
    cells.append(md_cell(f"Worked solutions are in the notebook `solutions-part-{n}.ipynb`, "
                         f"and in the [book's solutions]({solpage}#sec-solutions-review-{n})."))
    ml.append(f"% Worked solutions are in solutions_part{n}.m, and in the book:\n% {solpage}#sec-solutions-review-{n}\n")
    for k, body in rex:
        cells.append(md_cell(f"## Exercise {k}\n\n" + clean_markdown(body)))
        cells.append(code_cell("# Your code here"))
        ml.append(f"%% Exercise {k}\n" + comment(body) + "\n\n% Your code here\n")
    out = [(nb_name, notebook(cells), ml_name, "\n".join(ml))]

    # solutions
    nb_name, ml_name = f"solutions-part-{n}.ipynb", f"solutions_part{n}.m"
    what = "Worked solutions to the code exercises"
    cells = [md_cell(header_md(f"{pname}: solutions to the code exercises", solpage, nb_name, what)
                     .replace("Change the numbers", "Try each exercise yourself first. Change the numbers"))]
    ml = [ml_header(f"{pname}: solutions to the code exercises", solpage, what, ml_name)
          .replace("% Change the numbers", "% Try each exercise yourself first. Change the numbers")]
    funcs = []
    if "../data/" in soltxt:
        cells.append(code_cell(DATA_SETUP_PY)); ml.append("%% Data\n" + DATA_SETUP_ML + "\n")
    chapters = sorted(glob.glob(f"part-{n}/[0-9]*.qmd", root_dir=ROOT))
    for qmd in chapters + [review_qmd]:
        txt = read_qmd(os.path.join(ROOT, qmd))
        if qmd.endswith("review.qmd"):
            title, prefix = f"{pname} review", f"review-{n}"
        else:
            _, ctitle, sec = chapter_info(os.path.join(ROOT, qmd))
            label = XREF.get(sec, (None,))[0] or "Chapter " + str(int(os.path.basename(qmd)[:2]))
            title, prefix = f"{label}: {ctitle}", sec[4:]
        exs = code_exercises(txt)
        if not exs:
            continue
        cells.append(md_cell(f"## {title}"))
        ml.append("% " + "-" * 74 + f"\n% {to_plain(title)}\n% " + "-" * 74 + "\n")
        for k, body in exs:
            sol = solution_code(soltxt, f"{prefix}-{k}")
            cells.append(md_cell(f"### Exercise {k}\n\n" + clean_markdown(body)))
            ml.append(f"%% {to_plain(title).split(':')[0]}, exercise {k}\n" + comment(body) + "\n")
            if sol is None:
                print("  no code solution found for", prefix, k)
                continue
            add_solution(cells, ml, funcs, sol)
    if funcs:
        ml.append("%% Functions\n% MATLAB needs the functions used in a script to come at its end.\n\n" + "\n\n".join(unique_functions(funcs)) + "\n")
    out.append((nb_name, notebook(cells), ml_name, "\n".join(ml)))
    return out


def render(nb, ml):
    """The text of a notebook and a MATLAB script, as written to disk."""
    nb_text = json.dumps(nb, indent=1, ensure_ascii=False) + "\n"
    ml_text = re.sub(r"\n{3,}", "\n\n", ml).rstrip() + "\n"
    return nb_text, ml_text


def write(nb_name, nb, ml_name, ml):
    nb_text, ml_text = render(nb, ml)
    for folder, name, text in ((PY_DIR, nb_name, nb_text), (ML_DIR, ml_name, ml_text)):
        os.makedirs(os.path.join(ROOT, folder), exist_ok=True)
        with open(os.path.join(ROOT, folder, name), "w", encoding="utf-8", newline="\n") as f:
            f.write(text)


def check(items):
    """Compare what would be written with the files in code/; return the problems."""
    expected = {}
    for nb_name, nb, ml_name, ml in items:
        nb_text, ml_text = render(nb, ml)
        expected[f"{PY_DIR}/{nb_name}"] = nb_text
        expected[f"{ML_DIR}/{ml_name}"] = ml_text
    problems = []
    for rel, text in sorted(expected.items()):
        path = os.path.join(ROOT, rel)
        if not os.path.exists(path):
            problems.append(f"{rel}: missing")
            continue
        with open(path, encoding="utf-8", newline="") as f:
            current = f.read().replace("\r\n", "\n")
        if current != text:
            problems.append(f"{rel}: out of date")
    for folder, pattern in ((PY_DIR, "*.ipynb"), (ML_DIR, "*.m")):
        for path in glob.glob(os.path.join(ROOT, folder, pattern)):
            rel = f"{folder}/{os.path.basename(path)}"
            if rel not in expected:
                problems.append(f"{rel}: no longer made from any chapter (delete it?)")
    return problems


def main(args):
    checking = "--check" in args
    args = [a for a in args if a != "--check"]
    load_xrefs()
    files = args or sorted(glob.glob("part-*/[0-9]*.qmd", root_dir=ROOT))
    items = [build_chapter(qmd) for qmd in files]
    if not args:
        for n in range(1, 7):
            items.extend(build_part(n))
    if checking:
        if args:
            sys.exit("--check works on the whole book; leave out the chapter names")
        problems = check(items)
        for p in problems:
            print(p)
        if problems:
            print(f"\n{len(problems)} file(s) in code/ do not match the chapters. Render the book,\n"
                  "then run  python3 tools/make_code_files.py  and commit the changes.")
            sys.exit(1)
        print(f"All {2 * len(items)} files in code/ match the chapters.")
        return
    for item in items:
        write(*item)
    print(f"wrote {2 * len(items)} files in code/")


if __name__ == "__main__":
    main(sys.argv[1:])
