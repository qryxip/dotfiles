#!/bin/bash

set -euE -o pipefail

if [ "$TERM" = dumb ]; then
  yellow=''
  bold=''
  ansi_reset=''
else
  yellow=`echo -e '\e[33m'`
  bold=`echo -e '\e[1m'`
  ansi_reset=`echo -e '\e[m'`
fi

if [ "`whoami`" = root ]; then
  echo "${yellow}Don't run this script as root.${ansi_reset}"
  exit 1
fi

if [ ! -d ~/.opam ]; then
  opam init --comp 4.07.1
  opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
  opam update
  ghq get -u https://github.com/gfngfn/SATySFi
  cd ~/.ghq/github.com/gfngfn/SATySFi
  opam pin add satysfi
  opam install satysfi
fi
