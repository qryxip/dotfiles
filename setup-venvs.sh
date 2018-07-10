#!/bin/sh

set -euE -o pipefail

if [ ! -d ~/venvs/playground ]; then
  /usr/bin/python3.6 -m venv ~/venvs/playground
  ~/venvs/playground/bin/pip3.6 install click ptpython
fi

if [ ! -d ~/venvs/pygmentize ]; then
  /usr/bin/python3.6 -m venv ~/venvs/pygmentize
  ~/venvs/pygmentize/bin/pip3.6 install tw2.pygmentize
fi

if [ ! -d ~/venvs/ranger ]; then
  /usr/bin/python3.6 -m venv ~/venvs/ranger
  ~/venvs/ranger/bin/pip3.6 install ranger-fm
  ~/venvs/ranger/bin/ranger --copy-config=all
fi
