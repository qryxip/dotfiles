#!/bin/bash

if ! xdo id -n scratchpad > /dev/null; then
  alacritty --class scratchpad -e /bin/bash -c 'xdo id -n scratchpad > /tmp/scratchid && /usr/bin/tmux'
fi
