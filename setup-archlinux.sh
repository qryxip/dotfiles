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
    sudo groupadd uniput
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
    mkdir /tmp/install_packer
    wd=`pwd`
    cd /tmp/install_packer
    wget 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer' -O PKGBUILD
    makepkg -s
    sudo pacman -U `find -maxdepth 1 -name 'packer-*.pkg.tar.xz'`
    cd $wd
    rm -rf /tmp/install_packer
  fi

  packages=$(bash -c '
    PACKAGES="
      cmigemo-git
      cmus-git
      dropbox
      envchain
      intellij-jdk
      j4-dmenu-desktop
      nkf
      nvm
      otf-ipaexfont
      peco
      simple-mtpfs
      ttf-cica
      ttf-genshin-gothic
      ttf-myricam
      yabar-git
    "
    comm -23 <(printf "%s\n" $PACKAGES | sort) <(pacman -Qqm | sort)
  ')
  if [ -z "$packages" ]; then
    echo -e "\n${bold}No AUR packages to install.${ansi_reset}"
  else
    echo -e "\n${bold}Installing AUR packages...${ansi_reset}"
    packer -S --noconfirm $packages
  fi

  echo ''
  sudo systemctl enable ntpd
  sudo systemctl enable lightdm
  sudo systemctl enable bluetooth
  echo "${bold}Enabled systemd units.${ansi_reset}"
else
  echo '${yellow}This OS is not Arch Linux.${ansi_reset}'
fi
