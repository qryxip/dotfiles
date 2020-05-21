#!/bin/bash

if xrandr | grep 'HDMI1 connected' > /dev/null; then
  xrandr --output HDMI1 --auto --left-of eDP1
  bspc monitor HDMI1 -d I II III IV V VI VII VIII IX
  bspc monitor eDP1 -d X
else
  xrandr --output HDMI1 --off
  bspc monitor HDMI1 --remove
  bspc monitor eDP1 -d I II III IV V VI VII VIII IX X
fi

xbacklight = 100
xrdb ~/.Xresources

if ! ps cax | grep xkeysnail > /dev/null; then
  xkbcomp -I${HOME}/.xkb ${HOME}/.xkb/keymap/mykbd $DISPLAY
  xset r rate 200 50
  xset -b
fi

if ! ps cax | grep polybar > /dev/null; then
  polybar main &
fi

# device=`xinput list | sed -n 's/^⎜\s\+↳\sSynPS\/2\sSynaptics\sTouchPad\s\+id=\([0-9]\+\).*/\1/gp'`
# if [ -n "$device" ]; then
#   property=`xinput list-props 14 | sed -n 's/^\s\+libinput\sTapping\sEnabled\s(\([0-9]\+\)).*/\1/gp'`
#   if [ -n "$property" ]; then
#     xinput set-prop $device $property 1
#   fi
# fi

sleep 0.2

bspc config bottom_padding 0
bspc config left_padding 0
bspc config right_padding 0
picom -b --config ~/.config/compton/compton.conf

if type sky-color-wallpaper >/dev/null 2>/dev/null; then
  sky-color-wallpaper
fi
