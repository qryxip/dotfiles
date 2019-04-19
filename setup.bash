#!/bin/bash

set -euE -o pipefail

base=$(realpath $(dirname $0))

bash -c "./setup-common.bash"
bash -c "./setup-linux.bash"
bash -c "./setup-archlinux.bash"
bash -c "./setup-xkeysnail.bash"
bash -c "./setup-gems.bash"
bash -c "./setup-opam.bash"
bash -c "./setup-rustup.bash"
bash -c "./setup-venvs.bash"
