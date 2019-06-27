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

base=$(realpath $(dirname $0))

if [ "$(uname)" = Linux ]; then
  echo "${bold}Creating symlinks...${ansi_reset}"
  mkdir -p ~/.config/fcitx/skk ~/.config/qpdfview ~/.config/systemd/user ~/.local/share/applications
  for name in xkb.sh .rtorrent.rc .xprofile .Xresources .xkb; do
    ln -sf $base/linux/home/$name ~/
  done
  for name in bspwm compton dolphinrc libskk polybar rofi sxhkd yabar; do
    ln -sf $base/linux/home/.config/$name ~/.config/
  done
  for name in config conf; do
    ln -sf "$base/linux/home/.config/fcitx/$name" ~/.config/fcitx/
  done
  for name in dictionary_list rule; do
    ln -sf "$base/linux/home/.config/fcitx/skk/$name" ~/.config/fcitx/skk/
  done
  ln -sf $base/linux/home/.config/qpdfview/shortcuts.conf ~/.config/qpdfview/
  ln -sf $base/linux/home/.config/systemd/user/xkeysnail.service ~/.config/systemd/user/
  for name in cmus.desktop firefox.desktop org.kde.dolphin.desktop org.keepassxc.KeePassXC.desktop seahorse.desktop; do
    ln -sf "$base/linux/home/.local/share/applications/$name" ~/.local/share/applications/
  done

  echo "${bold}Copying files...${ansi_reset}"
  sudo mkdir -p /etc/sysctl.d /etc/systemd/swap.conf.d /etc/X11/xorg.conf.d
  sudo cp "$base/linux/etc/sysctl.d/60-my.conf" /etc/sysctl.d/
  sudo cp "$base/linux/etc/systemd/swap.conf.d/my.conf" /etc/systemd/swap.conf.d/
  sudo cp "$base/linux/etc/X11/xorg.conf.d/30-touchpad.conf" /etc/X11/xorg.conf.d/
  sudo cp "$base/linux/etc/X11/xorg.conf.d/50-mouse.conf" /etc/X11/xorg.conf.d/
else
  echo "${yellow}This OS is not Linux.${ansi_reset}"
fi
