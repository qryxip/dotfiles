.DEFAULT: update
.PHONY: update common linux archlinux toolchains envchain

update: toolchains

common:
	sh $$(pwd)/setup-common.sh

linux: common
	sh $$(pwd)/setup-linux.sh

archlinux: linux
	sh $$(pwd)/setup-archlinux.sh

toolchains: archlinux
	@sh $$(pwd)/setup-xkeysnail.sh
	@sh $$(pwd)/setup-venvs.sh
	@sh $$(pwd)/setup-gems.sh
	@sh $$(pwd)/setup-rustup.sh
	# @if [ -f /usr/bin/opam ]; then \
	#   echo 'todo' && \
	#   exit 1; \
	# fi

envchain:
	@sh $$(pwd)/setup-envchain.sh
