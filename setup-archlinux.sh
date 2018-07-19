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

wd=$(realpath $(dirname $0))

if [ -f /etc/arch-release ]; then
  sudo mkdir -p /usr/local/share/kbd/keymaps
  echo "${bold}Created /usr/local/share/kbd/keymaps${ansi_reset}"

  sudo cp $wd/archlinux/etc/locale.conf /etc/
  sudo cp $wd/archlinux/etc/vconsole.conf /etc/
  sudo cp $wd/archlinux/usr/local/share/kbd/keymaps/personal.map /usr/local/share/kbd/keymaps/
  echo "${bold}Copied files.${ansi_reset}"

  echo -e "\n${bold}Installing packages...${ansi_reset}"
  sudo pacman -S --needed --noconfirm archlinux-keyring gnome-keyring
  sudo pacman -S --needed --noconfirm dosfstools efibootmgr ntfs-3g encfs udisks2 arch-install-scripts
  sudo pacman -S --needed --noconfirm networkmanager openssh openconnect
  sudo pacman -S --needed --noconfirm fish tmux tig vim emacs
  sudo pacman -S --needed --noconfirm wget tree jq p7zip sysstat htop enca
  sudo pacman -S --needed --noconfirm go python-pip ruby jdk9-openjdk gradle opam
  sudo pacman -S --needed --noconfirm texlive-most texlive-langjapanese poppler-data
  sudo pacman -S --needed --noconfirm cmake freetype2 fontconfig pkg-config xclip
  sudo pacman -S --needed --noconfirm xf86-video-intel mesa xorg
  sudo pacman -S --needed --noconfirm lightdm lightdm-gtk-greeter light-locker bspwm sxhkd
  sudo pacman -S --needed --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol pamixer bluez bluez-utils
  sudo pacman -S --needed --noconfirm fcitx-skk skk-jisyo fcitx-configtool
  sudo pacman -S --needed --noconfirm feh w3m compton xcompmgr xorg-xkbcomp xsel
  sudo pacman -S --needed --noconfirm rxvt-unicode firefox chromium keepassxc seahorse qpdfview
  sudo pacman -S --needed --noconfirm numix-gtk-theme
  sudo pacman -S --needed --noconfirm awesome-terminal-fonts otf-ipafont

  if [ -f /usr/bin/packer ]; then
    echo -e "\n${bold}Packer already installed.${ansi_reset}"
  else
    echo -e "\n${bold}Installing packer...${ansi_reset}"
    mkdir -p /tmp/install_packer
    cd /tmp/install_packer
    wget 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer' -O PKGBUILD
    makepkg -s
    sudo pacman -U `find -maxdepth 1 -name 'packer-*.pkg.tar.xz'`
    cd $wd
    rm -rf /tmp/install_packer
  fi

  echo -e "\n${bold}Installing AUR packages...${ansi_reset}"
  if [ ! -f /usr/share/fonts/OTF/ipaexm.ttf ]; then packer -S otf-ipaexfont; fi
  if [ ! -f /usr/share/fonts/TTF/Cica-Regular.ttf ]; then packer -S ttf-cica; fi
  if [ ! -f /usr/share/fonts/TTF/GenShinGothic-Regular.ttf ]; then packer -S ttf-genshin-gothic; fi
  if [ ! -f /usr/share/fonts/TTF/FiraMono-Regular.ttf ]; then packer -S fira-code; fi
  if [ ! -f /usr/share/nvm/init-nvm.sh ]; then packer -S nvm; fi
  if [ ! -f /usr/bin/cmigemo ]; then packer -S cmigemo-git; fi
  if [ ! -f /usr/bin/cmus ]; then packer -S cmus-git; fi
  if [ ! -f /usr/bin/envchain ]; then packer -S envchain; fi
  if [ ! -f /usr/bin/stack ]; then packer -S stack; fi
  if [ ! -f /usr/bin/yabar ]; then packer -S yabar-git; fi
  if [ ! -f /usr/bin/simple-mtpfs ]; then packer -S simple-mtpfs; fi

  sudo systemctl enable ntpd
  sudo systemctl enable lightdm
  sudo systemctl enable bluetooth
  echo -e "\n${bold}Enabled systemd units.${ansi_reset}"
else
  echo '${yellow}This OS is not Arch Linux.${ansi_reset}'
fi
