# Code files for *Matrices in Practice*

The code from each chapter of the book, ready to run.

- `python/` holds Jupyter notebooks. Open them in Jupyter or VS Code, or in
  [Google Colab](https://colab.research.google.com) using the links in the book.
- `matlab/` holds MATLAB scripts, which mostly also run in GNU Octave. Run them a section at a
  time, from the top.

| Files | Contents |
|:------|:---------|
| `python/NN-name.ipynb`, `matlab/chNN_name.m` | The code of chapter NN, with the code exercises at the end |
| `python/part-N-review.ipynb`, `matlab/partN_review.m` | The code exercises of the Part N review |
| `python/solutions-part-N.ipynb`, `matlab/solutions_partN.m` | Worked solutions to all the code exercises of Part N |

## Making the files

These files are generated from the chapters by `tools/make_code_files.py`, so don't edit them
by hand: change the chapter, then run, from the book's root folder,

```
quarto render
python3 tools/make_code_files.py
```

The script reads the rendered book in `_book/` to find the numbers of chapters, figures and
equations. A few solutions are given in the book in Python only; their MATLAB versions are in
`tools/matlab_solutions/`.

Code licensed under the [MIT licence](../LICENSE.md).
