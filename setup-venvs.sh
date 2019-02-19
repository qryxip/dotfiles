#!/bin/sh

set -euE -o pipefail

if [ "$TERM" = dumb ]; then
  yellow=''
  ansi_reset=''
else
  yellow=`echo -e '\e[33m'`
  ansi_reset=`echo -e '\e[m'`
fi

if [ "`whoami`" = root ]; then
  echo "${yellow}Don't run this script as root.${ansi_reset}"
  exit 1
fi

if [ ! -d ~/venvs/playground ]; then
  ~/.pyenv/versions/3.7.2/bin/python3 -m venv ~/venvs/playground
  ~/venvs/playground/bin/pip3 install click ptpython
fi

if [ ! -d ~/venvs/http ]; then
  ~/.pyenv/versions/3.7.2/bin/python3 -m venv ~/venvs/http
  ~/venvs/http/bin/pip3 install httpie
fi

if [ ! -d ~/venvs/pygmentize ]; then
  ~/.pyenv/versions/3.7.2/bin/python3 -m venv ~/venvs/pygmentize
  ~/venvs/pygmentize/bin/pip3 install tw2.pygmentize
fi

if [ ! -d ~/venvs/ranger ]; then
  ~/.pyenv/versions/3.7.2/bin/python3 -m venv ~/venvs/ranger
  ~/venvs/ranger/bin/pip3 install ranger-fm
  ~/venvs/ranger/bin/ranger --copy-config=all
fi
