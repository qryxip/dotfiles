.DEFAULT: update
.PHONY: update linux archlinux

update: linux archlinux

linux:
ifeq ($(shell uname), Linux)
	mkdir -p ~/.vim ~/.config/cmus ~/.config/fish ~/.config/ranger
	if [ ! -d ~/.vim/dein.vim ]; then git clone 'https://github.com/Shougo/dein.vim' ~/.vim/dein.vim; fi
	if [ ! -d ~/.emacs.d ]; then git clone 'https://github.com/syl20bnr/spacemacs' ~/.emacs.d; fi
	ln -sf $(shell pwd)/.eslintrc ~/
	ln -sf $(shell pwd)/.gvimrc ~/
	ln -sf $(shell pwd)/.ideavimrc ~/
	ln -sf $(shell pwd)/.latexmkrc ~/
	ln -sf $(shell pwd)/.turn-config ~/
	ln -sf $(shell pwd)/.tmux.conf ~/
	ln -sf $(shell pwd)/.vimrc ~/
	ln -sf $(shell pwd)/.zshrc ~/
	ln -sf $(shell pwd)/.spacemacs.d ~/
	ln -sf $(shell pwd)/.vim/snippets ~/.vim/
	ln -sf $(shell pwd)/.config/nvim ~/.config/
	ln -sf $(shell pwd)/.config/cmus/rc ~/.config/cmus
	ln -sf $(shell pwd)/.config/fish/config.fish ~/.config/fish/
	ln -sf $(shell pwd)/.config/ranger/rc.conf ~/.config/ranger/
endif

archlinux:
ifeq ($(wildcard /etc/arch-release), /etc/arch-release)
	mkdir -p ~/.config/cmus
	sudo mkdir -p /usr/local/share/kbd/keymaps
	sudo mkdir -p /usr/local/share/xkeysnail
	sudo pacman -S --needed python-pip
	if [ ! -f /usr/bin/xkeysnail ]; then sudo /usr/bin/pip3 install xkeysnail; fi
	ln -sf $(shell pwd)/archlinux/HOME/xkb.sh ~/
	ln -sf $(shell pwd)/archlinux/HOME/.xkb ~/
	ln -sf $(shell pwd)/archlinux/HOME/.config/bspwm ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/libskk ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/sxhkd ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/yabar ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/cmus/rc ~/.config/cmus/
	sudo cp archlinux/etc/vconsole.conf /etc/
	sudo cp archlinux/etc/systemd/system/xkeysnail.service /etc/systemd/system/
	sudo cp archlinux/usr/local/share/kbd/keymaps/personal.map /usr/local/share/kbd/keymaps/
	sudo cp archlinux/usr/local/share/xkeysnail/config.py /usr/local/share/xkeysnail/
endif
