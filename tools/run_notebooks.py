#!/usr/bin/env python3
"""Run every notebook in code/python and report any that fail.

Run it from the book's root folder:

    python3 tools/run_notebooks.py                   # check that they all run
    python3 tools/run_notebooks.py --save DIR        # also save copies with outputs
    python3 tools/run_notebooks.py --warn-only ...   # report failures but exit 0

The GitHub workflows use it: check-code.yml to check the notebooks on every
push, and publish.yml to put copies with outputs on the website (there,
a notebook that fails is published without outputs instead).
"""
import argparse
import glob
import os
import shutil
import sys
import time

import nbformat
from nbclient import NotebookClient
from nbclient.exceptions import CellExecutionError

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NB_DIR = os.path.join(ROOT, "code", "python")
IN_GITHUB = os.environ.get("GITHUB_ACTIONS") == "true"


def run(path, save_dir):
    nb = nbformat.read(path, as_version=4)
    client = NotebookClient(nb, timeout=600, kernel_name="python3",
                            resources={"metadata": {"path": os.path.dirname(path)}})
    client.execute()
    if save_dir:
        nbformat.write(nb, os.path.join(save_dir, os.path.basename(path)))


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--save", metavar="DIR", help="save copies with outputs in DIR")
    parser.add_argument("--warn-only", action="store_true", help="exit 0 even if a notebook fails")
    parser.add_argument("notebooks", nargs="*", help="notebooks to run (default: all of code/python)")
    args = parser.parse_args()

    paths = args.notebooks or sorted(glob.glob(os.path.join(NB_DIR, "*.ipynb")))
    if args.save:
        os.makedirs(args.save, exist_ok=True)

    failed = []
    for path in paths:
        name = os.path.relpath(path, ROOT)
        start = time.time()
        try:
            run(path, args.save)
            print(f"ok      {name}  ({time.time() - start:.0f} s)", flush=True)
        except CellExecutionError as err:
            failed.append(name)
            # the last lines of the traceback say what went wrong
            message = "\n".join(str(err).strip().splitlines()[-3:])
            print(f"FAILED  {name}\n{message}\n", flush=True)
            if IN_GITHUB:
                level = "warning" if args.warn_only else "error"
                print(f"::{level} file={name}::{message.splitlines()[-1]}")
            if args.save:    # publish the notebook without outputs rather than not at all
                shutil.copy(path, args.save)

    print(f"\n{len(paths) - len(failed)} of {len(paths)} notebooks ran without errors.")
    if failed:
        print("Failed:\n  " + "\n  ".join(failed))
        if not args.warn_only:
            sys.exit(1)


if __name__ == "__main__":
    main()
