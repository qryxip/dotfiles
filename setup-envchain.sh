#!/bin/sh

set -euE -o pipefail

if [ "$TERM" = dumb ]; then
  yellow=''
  ansi_reset=''
else
  yellow=`echo -e '\e[33m'`
  ansi_reset=`echo -e '\e[m'`
fi

if [ "`whoami`" = root ]; then
  echo "${yellow}Don't run this script as root.${ansi_reset}"
  exit 1
fi

envchain --set tus TUS_STUDENT_NUMBER \
                   TUS_PASSWORD \
                   TUS_VPN_URL
envchain --set wi2-300 WI2_300_USERNAME \
                       WI2_300_PASSWORD
envchain --set snowchains ATCODER_USERNAME \
                          ATCODER_PASSWORD \
                          HACKERRANK_USERNAME \
                          HACKERRANK_PASSWORD \
                          YUKICODER_REVEL_SESSION
