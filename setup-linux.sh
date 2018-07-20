#!/bin/sh

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

base=$(realpath $(dirname $0))

if [ "$(uname)" = Linux ]; then
  echo "${bold}Creating symlinks...${ansi_reset}"
  for name in xkb.sh .xprofile .Xresources .xkb; do
    ln -sf $base/linux/home/$name ~/
  done
  for name in bspwm compton libskk sxhkd yabar; do
    ln -sf $base/linux/home/.config/$name ~/.config/
  done
  ln -sf $base/linux/home/.local/share/applications/cmus.desktop ~/.local/share/applications/
  cp $base/linux/home/.config/systemd/user/xkeysnail.service ~/.config/systemd/user/
else
  echo "${yellow}This OS is not Linux.${ansi_reset}"
fi
