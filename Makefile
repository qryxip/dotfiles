.DEFAULT: update
.PHONY: update archlinux

update: common archlinux

common:
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
	mkdir -p ~/.config/cmus ~/.config/fish ~/.config/ranger
	ln -sf $(shell pwd)/.config/cmus/rc ~/.config/cmus
	ln -sf $(shell pwd)/.config/fish/config.fish ~/.config/fish/
	ln -sf $(shell pwd)/.config/ranger/rc.conf ~/.config/ranger/
	if [ ! -d ~/.vim/dein.vim ]; then git clone 'https://github.com/Shougo/dein.vim' ~/.vim/dein.vim; fi
	if [ ! -d ~/.emacs.d ]; then git clone 'https://github.com/syl20bnr/spacemacs' ~/.emacs.d; fi

archlinux:
ifeq ($(wildcard /etc/arch-release),/etc/arch-release)
	sudo pacman -S --needed archlinux-keyring
	sudo pacman -S --needed dosfstools efibootmgr ntfs-3g
	sudo pacman -S --needed  expac jshon wget
	if [ ! -f /usr/bin/packer ]; then \
	  mkdir -p ~/packages/packer && \
	  cd ~/packages/packer && \
	  wget "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer" && \
	  mv "PKGBUILD?h=packer" PKGBUILD && \
	  makepkg && \
	  echo "todo: sudo pacman -U"; \
	fi
	sudo pacman -S --needed openssh
	sudo pacman -S --needed xf86-video-intel
	sudo pacman -S --needed mesa lightdm bspwm sxhkd
	sudo systemctl enable lightdm.service
	ln -sf $(shell pwd)/archlinux/HOME/.config/bspwm ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/libskk ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/sxhkd ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/yabar ~/.config/
	ln -sf $(shell pwd)/archlinux/HOME/.config/cmus/rc ~/.config/cmus/
	sudo cp archlinux/etc/locale.conf /etc/
	sudo cp archlinux/etc/vconsole.conf /etc/
	sudo cp archlinux/usr/local/share/kbd/keymaps/personal.map /usr/local/share/kbd/keymaps/
endif
