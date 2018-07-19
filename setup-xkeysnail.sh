#!/bin/sh

# https://qiita.com/miy4/items/dd0e2aec388138f803c5

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

if [ -d /opt/xkeysnail ]; then
  echo "${bold}xkeysnail is already installed.${ansi_reset}"
else
  sudo /usr/bin/python3 -m venv /opt/xkeysnail
  sudo /opt/xkeysnail/bin/pip3 install xkeysnail
fi

if cat /etc/passwd | grep xkeysnail > /dev/null; then
  echo "${bold}User 'xkeysnail' already exists.${ansi_reset}"
else
  sudo groupadd uniput
  sudo useradd -G input,uinput -s /sbin/nologin xkeysnail
fi

echo "${bold}Copying files...${ansi_reset}"
sudo cp $wd/archlinux/etc/udev/rules.d/40-udev-xkeysnail.rules /etc/udev/rules.d/
sudo cp $wd/archlinux/etc/modules-load.d/uinput.conf /etc/modules-load.d/
sudo cp $wd/archlinux/etc/sudoers.d/10-installer  /etc/sudoers.d/

echo "${bold}OK. Restart the system.${ansi_reset}"
