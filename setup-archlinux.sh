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
  sudo pacman -S --needed --noconfirm \
    archlinux-keyring gnome-keyring \
    arch-audit pacman-contrib \
    dosfstools efibootmgr ntfs-3g encfs udisks2 \
    arch-install-scripts dialog \
    wpa_supplicant wpa_actiond dhclient networkmanager openssh openconnect \
    wget rtorrent \
    ntp \
    zsh fish tmux \
    vim emacs \
    tig hub ripgrep fd bat tree jq p7zip unarchiver enca \
    lldb \
    sysstat htop \
    perf valgrind kcov \
    go python-pip ruby jdk10-openjdk gradle opam \
    android-tools \
    texlive-most texlive-langjapanese poppler-data \
    ttf-junicode otf-latinmodern-math \
    cmake freetype2 fontconfig pkg-config xclip \
    postgresql mariadb \
    xf86-video-intel mesa xorg \
    lightdm lightdm-gtk-greeter light-locker bspwm sxhkd \
    libmpd libmpdclient pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol pamixer gnome-alsamixer playerctl bluez bluez-utils \
    fcitx-skk skk-jisyo fcitx-configtool \
    feh gmic w3m compton xcompmgr xorg-xkbcomp xsel gendesk \
    alacritty rxvt-unicode rofi \
    firefox chromium \
    keepassxc seahorse qpdfview \
    numix-gtk-theme \
    awesome-terminal-fonts otf-ipafont ttf-liberation wqy-zenhei \
    xf86-input-wacom krita \
    steam lib32-mesa libidn11 \
    figlet sl fortune cowsay cmatrix

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

  packages=$(bash -c '
    PACKAGES="
      cmigemo-git
      cmus-git
      dropbox
      envchain
      gitflow-avh
      intellij-jdk
      nerds-fonts-complete
      nkf
      nvm
      otf-ipaexfont
      peco
      polybar
      powershell-bin
      pyenv
      simple-mtpfs
      spotify
      ttf-cica-git
      ttf-genshin-gothic
      ttf-myricam
    "
    comm -23 <(printf "%s\n" $PACKAGES | sort) <(pacman -Qqm | sort)
  ')
  if [ -z "$packages" ]; then
    echo -e "\n${bold}No AUR packages to install.${ansi_reset}"
  else
    echo -e "\n${bold}Installing AUR packages...${ansi_reset}"
    yay -S --noconfirm $packages
  fi

  echo ''
  sudo systemctl enable ntpd
  sudo systemctl enable lightdm
  sudo systemctl enable bluetooth
  echo "${bold}Enabled systemd units.${ansi_reset}"
else
  echo '${yellow}This OS is not Arch Linux.${ansi_reset}'
fi
