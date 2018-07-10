#!/bin/sh

# https://qiita.com/miy4/items/dd0e2aec388138f803c5

set -euE -o pipefail

cd `dirname $0`

if [ -d /opt/xkeysnail ]; then
  echo 'xkeysnail is already installed.'
else
  sudo /usr/bin/python3 -m venv /opt/xkeysnail
  sudo /opt/xkeysnail/bin/pip3 install xkeysnail
fi

if cat /etc/passwd | grep xkeysnail > /dev/null; then
  echo 'User "xkeysnail" already exists.'
else
  sudo groupadd uniput
  sudo useradd -G input,uinput -s /sbin/nologin xkeysnail
fi

echo 'Copying files...'
sudo cp archlinux/etc/udev/rules.d/40-udev-xkeysnail.rules /etc/udev/rules.d/
sudo cp archlinux/etc/modules-load.d/uinput.conf /etc/modules-load.d/
sudo cp archlinux/etc/sudoers.d/10-installer  /etc/sudoers.d/

echo 'OK. Restart the system.'
