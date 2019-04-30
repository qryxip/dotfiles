#!/bin/bash

set -euE -o pipefail

if [ "$TERM" = dumb ]; then
  red=''
  yellow=''
  bold=''
  ansi_reset=''
else
  red=`echo -e '\e[31m'`
  yellow=`echo -e '\e[33m'`
  bold=`echo -e '\e[1m'`
  ansi_reset=`echo -e '\e[m'`
fi

if [ "`whoami`" = root ]; then
  echo "${yellow}Don't run this script as root.${ansi_reset}"
  exit 1
fi

if ! which node > /dev/null 2>&1; then
  echo "${red}"'`node`'" not found.${ansi_reset}"
  exit 1
fi

if [ "$(which npm)" = "/usr/bin/npm" ]; then
  echo "${red}"'`npm`'" is "'`/usr/bin/npm`'."${ansi_reset}"
  exit 1
fi

node_version=$(node --version)

dir=~/tools/node/"$node_version"/textlint
if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
  cd "$dir"
  echo '{"private":true}' > ./package.json
  npm i textlint textlint-rule-proofdict
fi

dir=~/tools/node/"$node_version"/typescript
if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
  cd "$dir"
  echo '{"private":true}' > ./package.json
  npm i typescript
fi
