#!/bin/bash

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
  ~/.cargo/bin/rustup install 1.15.1 1.38.0 nightly
  ~/.cargo/bin/rustup component add rust-src rust-analysis rls clippy rustfmt --toolchain stable
  # ~/.cargo/bin/rustup component add clippy rustfmt --toolchain nightly
  ~/.cargo/bin/cargo +stable install \
                     cargo-asm \
                     cargo-audit \
                     cargo-bloat \
                     cargo-clone \
                     cargo-count \
                     cargo-crev \
                     cargo-deny \
                     cargo-deps \
                     cargo-edit \
                     cargo-generate \
                     cargo-license \
                     cargo-make \
                     cargo-outdated \
                     cargo-profiler \
                     cargo-script \
                     cargo-tree\
                     cargo-update \
                     cross \
                     diesel_cli \
                     exa \
                     fselect \
                     mdbook \
                     onefetch \
                     starship \
                     tokei
  ~/.cargo/bin/cargo +stable install --git https://github.com/rust-analyzer/rust-analyzer ra_lsp_server
  ~/.cargo/bin/cargo +stable install --git https://github.com/google/pix-image-viewer
  # ~/.cargo/bin/cargo +stable install cargo-local-registry
  # ~/.cargo/bin/cargo +nightly install cargo-modules
  ~/.cargo/bin/cargo +nightly install racer
  RUSTFLAGS="--cfg procmacro2_semver_exempt" ~/.cargo/bin/cargo +nightly install cargo-tarpaulin
fi
