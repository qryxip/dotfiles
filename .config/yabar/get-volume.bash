#!/bin/bash
volume=$(pamixer --get-volume)
if [ $volume -eq 0 ]; then
  echo '   0%'
else
  printf ' %3s%%\n' ${volume}
fi
