#!/bin/bash

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

PYTHON_VERSION=3.7.2

if [ ! -d ~/.pyenv/versions/"$PYTHON_VERSION" ]; then
  pyenv install "$PYTHON_VERSION"
  pyenv global "$PYTHON_VERSION"
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/aws ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION/bin/python3" -m venv ~/tools/python/"$PYTHON_VERSION"/aws
  ~/tools/python/"$PYTHON_VERSION"/aws/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/aws/bin/pip3 install awscli
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/http ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION/bin/python3" -m venv ~/tools/python/"$PYTHON_VERSION"/http
  ~/tools/python/"$PYTHON_VERSION"/http/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/http/bin/pip3 install httpie
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/oj ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION/bin/python3" -m venv ~/tools/python/"$PYTHON_VERSION"/oj
  ~/tools/python/"$PYTHON_VERSION"/oj/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/oj/bin/pip3 install online-judge-tools
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/pipenv ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION"/bin/python3 -m venv ~/tools/python/"$PYTHON_VERSION"/pipenv
  ~/tools/python/"$PYTHON_VERSION"/pipenv/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/pipenv/bin/pip3 install pipenv
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/ptpython ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION/bin/python3" -m venv ~/tools/python/"$PYTHON_VERSION"/ptpython
  ~/tools/python/"$PYTHON_VERSION"/ptpython/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/ptpython/bin/pip3 install ptpython
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/pygmentize ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION/bin/python3" -m venv ~/tools/python/"$PYTHON_VERSION"/pygmentize
  ~/tools/python/"$PYTHON_VERSION"/pygmentize/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/pygmentize/bin/pip3 install tw2.pygmentize
fi

if [ ! -d ~/tools/python/"$PYTHON_VERSION"/ranger ]; then
  ~/.pyenv/versions/"$PYTHON_VERSION/bin/python3" -m venv ~/tools/python/"$PYTHON_VERSION"/ranger
  ~/tools/python/"$PYTHON_VERSION"/ranger/bin/pip3 install -U pip
  ~/tools/python/"$PYTHON_VERSION"/ranger/bin/pip3 install ranger-fm
  ~/tools/python/"$PYTHON_VERSION"/ranger/bin/ranger --copy-config=all
fi
