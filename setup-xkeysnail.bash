#!/bin/bash

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

if [ -d /opt/xkeysnail ]; then
  echo "${bold}xkeysnail is already installed.${ansi_reset}"
elif [ -f /etc/arch-release ]; then
  echo "${bold}Installing xkeysnail...${ansi_reset}"
  sudo /usr/bin/python3 -m venv /opt/xkeysnail
  sudo /opt/xkeysnail/bin/pip3 install -U pip
  sudo /opt/xkeysnail/bin/pip3 install xkeysnail
  sudo cp $(realpath $(dirname $0))/linux/opt/xkeysnail/config.py /opt/xkeysnail/
else
  echo "${bold}Skipping installing xkeysnail...${ansi_reset}"
fi
