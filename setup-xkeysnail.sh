#!/bin/sh

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
else
  echo "${bold}Installing xkeysnail...${ansi_reset}"
  sudo /usr/bin/python3 -m venv /opt/xkeysnail
  sudo /opt/xkeysnail/bin/pip3 install xkeysnail
fi
