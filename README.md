# Matrices in Practice

A Quarto book on matrices, linear algebra and numerical methods, with interactive apps and code in Python and MATLAB. It is published to GitHub Pages.

## Folder layout

| Path | Contents |
|:-----|:---------|
| `_quarto.yml` | Book settings, and the list of parts and chapters |
| `index.qmd`, `front/` | Welcome page, how to use the book, notation and conventions, refresher |
| `part-1/` to `part-6/` | Chapters, one `.qmd` file each |
| `appendices/` | Proofs, matrix calculus identities, solutions (one file per Part), glossary |
| `apps/` | Interactive apps (self-contained HTML), embedded in chapters |
| `code/` | Jupyter notebooks and MATLAB scripts of each chapter's code, generated from the chapters (see below) |
| `tools/` | `make_code_files.py`, which generates `code/`; `run_notebooks.py` and `run_matlab_scripts.m`, which check that the files run; and MATLAB versions of the few Python-only solutions |
| `assets/` | Notation settings script, fonts and themes |
| `references.bib` | Bibliography |
| `.github/workflows/publish.yml` | Builds and publishes the book on every push to `main` |
| `.github/workflows/check-code.yml` | Checks that `code/` matches the chapters and that every notebook and MATLAB script runs, on every push and weekly |

## Working on the book

1. Install [Quarto](https://quarto.org/docs/get-started/) and Python 3.
2. Install the Python packages: `pip install -r requirements.txt`
3. Preview with live reload: `quarto preview`
4. Build the whole book into `_book/`: `quarto render`

Python code runs when the book is built. With `freeze: auto`, a chapter's code only runs again when that chapter changes.

## Writing chapters

### Chapter pattern

Every chapter uses the same headings, so readers always know where to look:

1. A level badge: `[Core]{.level-badge .core}` or `[Further]{.level-badge .further}`
2. **In this chapter you will** (a callout listing outcomes)
3. **Builds on** (one line linking the chapters to revise first)
4. **Build intuition** (an app, a worked-by-hand example or a picture)
5. **The ideas**, with each worked example placed straight after the subsection it practises, so that explanation and practice alternate. Worked examples are callouts with ids `#ex-<chapter key>-<n>`, where the chapter key is the chapter's `sec-` id without the prefix, numbered in the order they appear.
6. **In code** (Python and MATLAB tabs)
7. **Check your understanding** (collapsible callouts)
8. **Key ideas** (four to six bullet points recapping the chapter)
9. **Exercises** (solutions in `appendices/solutions-N.qmd`, one file per Part)
10. **In practice**
11. **Going further** (links to proofs in `appendices/proofs.qmd`)

Any chapter in Parts I to V is a finished example of the pattern.

**Where apps go.** An app belongs in **Build intuition** only if a reader can make sense of it with what they already know, and its "Things to try" must not depend on ideas the chapter has yet to explain. When an app (or part of one) needs the chapter's new ideas, put it, or its activities, straight after the section that explains them: either a second embed of the same app, opened in the right mode with start-up settings (as in Chapters 10, 21 and 27), or a short "go back to the app" prompt (as in Chapters 25 and 29). Chapter 11 moves its app into **The ideas** entirely, and opens with a small example done by hand.

The application chapters in Part VI use a shorter pattern, since each one starts from a real problem:

1. A level badge
2. **In this chapter you will**
3. **Builds on** (links to the chapters it uses)
4. **The problem** (the real context)
5. **The model** (the mathematics, with worked examples as callouts)
6. **Explore** (an app with things to try, or a figure with things to try in code)
7. **In code** (Python and MATLAB tabs)
8. **Check your understanding** (three quick questions, with answers that open on click)
9. **Key ideas**
10. **Exercises** (solutions in `appendices/solutions-N.qmd`, one file per Part)
11. **Going further**

Each Part ends with an unnumbered **Part review** page (`part-N/review.qmd`; Quarto can't cross-reference an unnumbered page, so link to it by file name): eight or nine exercises that mix the Part's chapters with earlier ones, without naming chapters, including one code exercise. Their solutions are at the end of `appendices/solutions-N.qmd` (`sec-solutions-review-N`), and each one starts by listing the chapters it uses.

All six parts are written. Data files used by the code, such as `data/iris.csv`, live in `data/`, which is copied into the built book.

### Notation macros: always use these

Readers choose their own notation with the **Notation** button, so mathematics must use these macros rather than hard-coded notation. They are defined in `assets/notation-header.html`.

| Write | For | Default appearance |
|:------|:----|:-------------------|
| `\vect{v}` | a vector | bold **v** |
| `\M{A}` | a matrix | bold **A** |
| `\ui`, `\uj`, `\uk` | unit vectors along the axes | bold **i**, **j**, **k** |
| `\ue{n}` | general basis vector | bold **e**ₙ |
| `\zerovec` | zero vector | bold **0** |
| `\mat{1 & 2 \\ 3 & 4}` | a matrix in brackets | round brackets |
| `\amat{rr|r}{1 & 2 & 3 \\ 4 & 5 & 6}` | an augmented matrix | round brackets with a divider |
| `\M{A}\T` | transpose | superscript T |
| `\R^n` | real vector space | blackboard bold R |

Only write a specific notation directly (for example `\mathbf{i}`) when you are *showing* that notation, as on the conventions page.

### Code in two languages

Put the Python and MATLAB versions in a tabset with `group="language"`, so that choosing a tab switches every example in the book:

````markdown
::: {.panel-tabset group="language"}
## Python

```{python}
import numpy as np
print(np.linalg.solve([[2, 1], [1, 3]], [3, 5]))
```

## MATLAB

```matlab
x = [2 1; 1 3] \ [3; 5]
```

```{.text .code-output}
x =

    0.8000
    1.4000
```
:::
````

Keep the tab names exactly `Python` and `MATLAB`.

Python runs during the build. MATLAB does not, so MATLAB code is shown with its output pasted below it. Check MATLAB examples in MATLAB or in [GNU Octave](https://octave.org) before pasting the output.

### Notebooks and MATLAB scripts

`code/` holds a Jupyter notebook and a MATLAB script for each chapter, for each part review's code exercise, and for the worked solutions of each part. Every chapter, review and solutions page links to its files, and the notebooks open in Google Colab straight from GitHub. Don't edit these files by hand: they are generated from the chapters. After changing any code, an exercise marked **Code.**, or its solution, run

```
quarto render
python3 tools/make_code_files.py
```

and commit the changed files in `code/` (the script reads `_book/` for chapter, figure and equation numbers). `python3 tools/make_code_files.py --check` lists any files that are out of date without changing anything. If a code solution is given in Python only, put its MATLAB version in `tools/matlab_solutions/<exercise id>.m`, with any functions it defines in `<exercise id>.functions.m`. A new chapter's code is picked up automatically if it is under a `## In code` heading in Python/MATLAB tabs; add the `::: {.code-files}` link block under that heading, copied from another chapter.

The **Check code** workflow (`.github/workflows/check-code.yml`) checks these files on every push and pull request, and every Monday so that a new release of NumPy, SciPy, Matplotlib or MATLAB that breaks the code is noticed. It fails if `code/` doesn't match the chapters, if a notebook raises an error, or if a MATLAB script does; the failing file and line show on the run's summary page under the **Actions** tab. MATLAB is free on GitHub's servers for public repositories, so the MATLAB check needs no licence while the repository stays public. It installs the Optimization Toolbox too, for `fsolve` in Chapter 28; if the book's code comes to use another toolbox, add it to the `products:` line in the workflow. A failed check doesn't stop the book being published. To run the checks yourself:

```
python3 tools/make_code_files.py --check
python3 tools/run_notebooks.py
matlab -batch "addpath(fullfile(pwd, 'tools')); run_matlab_scripts"
```

The notebooks in the repository have no outputs, so they stay small and Colab opens them clean. When the book is published, the notebooks on the website are run first, so a reader who downloads one sees the results before running it; a notebook that fails is published without outputs instead.

### Embedding an app

Put the app's HTML file in `apps/`, then add this to the chapter:

```markdown
::: {.app-embed}
<iframe class="app-frame" src="../apps/my-app.html?embed=1" title="My app" loading="lazy"></iframe>

[Open my app in its own tab](../apps/my-app.html){.app-open target="_blank"}
:::
```

The book resizes the frame to fit the app. With `?embed=1`, the app hides its own title, follows the book's light or dark theme, and uses the reader's bracket and unit-vector settings (see the script near the top of either existing app).

### Cross-references

- Chapters: `@sec-gaussian-elimination` (the label is in each chapter's first heading)
- Proofs: `@sec-proofs-gaussian-elimination`
- Solutions: `@sec-solutions-gaussian-elimination`
- Exercises and solutions link both ways. Each exercise starts with an anchor, `1. []{#exercise-<chapter key>-1}...`, and ends with an indented paragraph `[Solution to exercise 1](../appendices/solutions-N.qmd#solution-<chapter key>-1){.sol-link}`. Each solution starts with `[**1.**]{#solution-<chapter key>-1}` and ends with `[Back to exercise 1](../part-N/<chapter file>.qmd#exercise-<chapter key>-1){.sol-link}`. For a Part review, the key is `review-N`. When you add, remove or renumber an exercise, update both ends.
- Equations: label with `$$ ... $$ {#eq-name}` and refer with `@eq-name`

### Accessibility and small screens

- **Every figure needs alt text.** For an image, use `![Caption](file.png){fig-alt="..."}`. For a figure drawn by code, add `#| fig-alt: "..."` to the cell. Say what the figure shows (the trend, the shape, the key values), not how it was drawn.
- **Tables need a header in every column**, including the first. Write `| Shop | Flour | ... |`, not `| | Flour | ... |`.
- **Wide displays.** A matrix with more than about six columns goes in a `::: {.wide-matrix}` div (or `{.wide-matrix .very-wide}`), with blank lines before and after it. Long chains of equalities should be split with `aligned` so they fit a 320-pixel screen.
- **Avoid long inline maths** such as a matrix or a six-number tuple in running text; it cannot wrap. Use a display, or plain text for lists of numbers.
- `assets/notation-header.html` ends with a script that repairs some of Quarto's markup: it makes the "Check your understanding" headers keyboard-operable buttons, labels the sidebar landmark, and makes sideways-scrolling code output focusable.
- **Apps** must keep: an `aria-label` on every control, `tabindex="0"` with `role="region"` on any scrolling box, checkboxes inside their `<label>`, and a Play/Pause button for any animation (never start moving on load). If the reader's device asks for reduced motion (`prefers-reduced-motion`), Play shows the end result at once instead of animating, as in the iteration race and row reduction apps; only motion that is the point of the app (the normal modes) still animates, and only when Play is pressed.
- **Never make dragging the only way** (WCAG 2.2). A point that can be dragged must also move to where the reader clicks; when there are several, add a **Move:** row of buttons choosing which one a click (and the arrow keys) moves, as in the vector mixer, basis grids and vector explorer. A 3D view that turns by dragging needs **Turn** buttons (they send the arrow keys to the canvas), as in the span explorer. Anything the mouse can change, the keyboard must change too.
- **Colours drawn on a canvas** (lines, grids, labels) need 3:1 contrast against the plot background in both themes, at the opacity they are drawn with. Automated checkers cannot see inside a canvas.
- **Small controls** need a target of at least 24 by 24 pixels; `assets/components.scss` enlarges Quarto's own (the GitHub button, "Edit this page", breadcrumbs).

To check, render, serve `_book` locally and run [axe-core](https://github.com/dequelabs/axe-core) over every page and app, in light and dark modes, with the WCAG 2.2 rules on, and load each page at 320, 390, 768 and 1280 pixels wide. Make sure MathJax actually loads in the test browser (if the CDN is blocked, serve a local copy of `mathjax@4.0.0`): without it the maths is missing and the results are misleading.

## Publishing to GitHub Pages

One-time setup:

1. Create a GitHub repository and push this folder to its `main` branch.
2. On your computer, run `quarto publish gh-pages` once. This creates the `gh-pages` branch.
3. In the repository on GitHub, go to **Settings → Pages** and set the source to the `gh-pages` branch.
4. `repo-url` in `_quarto.yml` is set to `https://github.com/trgoodale/matrix-book`; change it if the repository moves.

After that, every push to `main` rebuilds and publishes the book automatically, with freshly generated code files. Progress shows under the repository's **Actions** tab.

## A note on OneDrive

This folder is inside OneDrive. Git and OneDrive can work together, but OneDrive sometimes locks files or syncs the `.git` folder mid-change, which can corrupt a repository. If you see problems, move the repository to a folder outside OneDrive (for example `C:\Users\<you>\repos\matrix-book`). GitHub then becomes your backup.
