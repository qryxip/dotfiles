#!/bin/bash

if [ "$TERM" = dumb ]; then
  yellow=''
  ansi_reset=''
else
  yellow=`echo -e '\e[33m'`
  ansi_reset=`echo -e '\e[m'`
fi

if [ "`whoami`" = root ]; then
  >&2 echo "${yellow}Don't run this script as root.${ansi_reset}"
  exit 1
fi

if [ ! -d /nix ]; then
  bash <(curl https://nixos.org/nix/install) &&
  source ~/.nix-profile/etc/profile.d/nix.sh &&
  unprivileged_userns_clone="$(cat /proc/sys/kernel/unprivileged_userns_clone || exit 1)"
  sudo echo 1 > /proc/sys/kernel/unprivileged_userns_clone &&
  nix-env -iA cachix -f https://cachix.org/api/v1/install &&
  cachix use all-hies &&
  nix-env -iA selection --arg selector 'p: { inherit (p) ghc865; }' -f https://github.com/infinisil/all-hies/tarball/master &&
  sudo echo "$unprivileged_userns_clone" > /proc/sys/kernel/unprivileged_userns_clone
fi
