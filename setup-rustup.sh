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

if [ -f ~/.cargo/bin/racer ]; then
  echo "${bold}rustup and Rust tools are already installed.${ansi_reset}"
else
  echo "${bold}Installing rustup and Rust tools...${ansi_reset}"
  wget https://sh.rustup.rs -O /tmp/rustup-init
  sh /tmp/rustup-init -y --no-modify-path --default-toolchain stable
  ~/.cargo/bin/rustup install 1.15.1 nightly
  ~/.cargo/bin/rustup component add rust-src rust-analysis rls-preview --toolchain stable
  ~/.cargo/bin/rustup component add clippy-preview rustfmt-preview --toolchain nightly
  ~/.cargo/bin/cargo +stable install cargo-edit cargo-generate cargo-license cargo-script cargo-outdated cargo-update exa fselect tokei
  ~/.cargo/bin/cargo +stable install --git https://github.com/jwilm/alacritty
  ~/.cargo/bin/cargo +nightly install racer
fi
