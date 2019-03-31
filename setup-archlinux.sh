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

if [ -f /etc/arch-release ]; then
  sudo mkdir -p /usr/local/share/kbd/keymaps
  echo "${bold}Created /usr/local/share/kbd/keymaps${ansi_reset}"

  # https://qiita.com/miy4/items/dd0e2aec388138f803c5
  if cat /etc/passwd | grep xkeysnail > /dev/null; then
    echo "${bold}User 'xkeysnail' already exists.${ansi_reset}"
  else
    sudo groupadd uinput || true
    sudo useradd -G input,uinput -s /sbin/nologin xkeysnail
    echo "${bold}Added user 'xkeysnail' and group 'uinput'.${ansi_reset}"
  fi

  base=$(realpath $(dirname $0))
  sudo cp $base/archlinux/usr/local/share/kbd/keymaps/personal.map /usr/local/share/kbd/keymaps/
  sudo cp $base/archlinux/etc/locale.conf /etc/
  sudo cp $base/archlinux/etc/vconsole.conf /etc/
  sudo cp $base/archlinux/etc/udev/rules.d/40-udev-xkeysnail.rules /etc/udev/rules.d/
  sudo cp $base/archlinux/etc/modules-load.d/uinput.conf /etc/modules-load.d/
  sudo cp $base/archlinux/etc/sudoers.d/10-installer  /etc/sudoers.d/
  echo "${bold}Copied files.${ansi_reset}"

  echo -e "\n${bold}Installing packages...${ansi_reset}"
  cat "$base/archlinux/native.txt" | xargs sudo pacman -S --needed --noconfirm

  if [ -x /usr/bin/yay ]; then
    echo -e "\n${bold}yay already installed.${ansi_reset}"
  else
    echo -e "\n${bold}Installing yay...${ansi_reset}"
    mkdir /tmp/yay_installation
    wd=`pwd`
    cd /tmp/yay_installation
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd $wd
    rm -rf /tmp/yay_installation
  fi

  packages=$(bash -c 'comm -23 "$base/archlinux/foreign.txt" <(pacman -Qmq | sort)')
  if [ -z "$packages" ]; then
    echo -e "\n${bold}No AUR packages to install.${ansi_reset}"
  else
    echo -e "\n${bold}Installing AUR packages...${ansi_reset}"
    yay -S --noconfirm $packages
  fi

  if [ -d ~/.dropbox-dist ]; then
    rm -rf ~/.dropbox-dist
  fi
  install -dm0 ~/.dropbox-dist # A hack to prevent automatic updates
  echo "${bold}Sealed `~/.dropbox-dist`.${ansi_reset}"
  systemctl --user disable dropbox

  echo ''
  sudo systemctl enable ntpd
  sudo systemctl enable lightdm
  sudo systemctl enable bluetooth
  echo "${bold}Enabled systemd units.${ansi_reset}"
else
  echo '${yellow}This OS is not Arch Linux.${ansi_reset}'
fi
