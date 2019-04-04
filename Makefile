.DEFAULT: all
.PHONY: all common linux archlinux toolchains envchain

all: toolchains

common:
	sh $$(pwd)/setup-common.bash

linux: common
	sh $$(pwd)/setup-linux.bash

archlinux: linux
	sh $$(pwd)/setup-archlinux.bash

toolchains: archlinux
	@sh $$(pwd)/setup-xkeysnail.bash
	@sh $$(pwd)/setup-gems.bash
	@sh $$(pwd)/setup-opam.bash
	@sh $$(pwd)/setup-rustup.bash
	@sh $$(pwd)/setup-venvs.bash

envchain:
	@sh $$(pwd)/setup-envchain.bash
