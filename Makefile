.DEFAULT: update
.PHONY: update common linux archlinux

update: archlinux

common:
	@echo 'Making directories...'
	@mkdir -p ~/.vim ~/.config/cmus ~/.config/fish ~/.config/ranger/colorschemes
	@echo 'Creating symlinks...'
	@for name in .eslintrc .gvimrc .ideavimrc .latexmkrc .tern-config .tmux.conf .vimrc .zshrc .spacemacs.d .Xresources; do \
	  ln -sf $$(pwd)/$$name ~/; \
	done
	@ln -sf $(shell pwd)/.config/nvim ~/.config/
	@ln -sf $(shell pwd)/.config/cmus/rc ~/.config/cmus
	@ln -sf $(shell pwd)/.config/fish/config.fish ~/.config/fish/
	@ln -sf $(shell pwd)/.config/ranger/rc.conf ~/.config/ranger/
	@ln -sf $(shell pwd)/.config/ranger/colorschemes/mytheme.py ~/.config/ranger/colorschemes/
	@ln -sf $(shell pwd)/.vim/snippets ~/.vim/
	@if [ ! -d ~/.vim/dein.vim ]; then git clone 'https://github.com/Shougo/dein.vim' ~/.vim/dein.vim; fi
	@if [ ! -d ~/.emacs.d ]; then git clone 'https://github.com/syl20bnr/spacemacs' ~/.emacs.d; fi

linux: common
ifeq ($(shell uname), Linux)
	@echo 'Creating symlinks...'
	@for name in xkb.sh .xprofile .xkb; do \
	  ln -sf $$(pwd)/archlinux/HOME/$$name ~/; \
	done
	@for name in bspwm compton libskk sxhkd yabar; do \
	  ln -sf $$(pwd)/archlinux/HOME/.config/$$name ~/.config/; \
	done
endif

archlinux: linux
ifeq ($(wildcard /etc/arch-release), /etc/arch-release)
	@echo 'Making directories...'
	@sudo mkdir -p /usr/local/share/kbd/keymaps /usr/local/share/xkeysnail
	@echo 'Copying files...'
	@sudo cp archlinux/etc/locale.conf /etc/
	@sudo cp archlinux/etc/vconsole.conf /etc/
	@sudo cp archlinux/etc/systemd/system/xkeysnail.service /etc/systemd/system/
	@sudo cp archlinux/usr/local/share/kbd/keymaps/personal.map /usr/local/share/kbd/keymaps/
	@sudo cp archlinux/usr/local/share/xkeysnail/config.py /usr/local/share/xkeysnail/
	@echo 'Installing packages...'
	@sudo pacman -S --needed --noconfirm archlinux-keyring gnome-keyring
	@if [ ! -f /usr/bin/packer ]; then \
	  echo 'Installing packer...' && \
	  sudo pacman -S --needed --noconfirm expac jshon wget && \
	  mkdir -p ~/packages/packer && \
	  cd ~/packages/packer && \
	  wget "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer" && \
	  mv "PKGBUILD?h=packer" PKGBUILD && \
	  makepkg && \
	  echo "todo: sudo pacman -U" && \
	  exit 1; \
	fi
	@sudo pacman -S --needed --noconfirm dosfstools efibootmgr ntfs-3g encfs
	@sudo pacman -S --needed --noconfirm networkmanager openssh
	@sudo pacman -S --needed --noconfirm fish tmux tree jq p7zip vim emacs
	@sudo pacman -S --needed --noconfirm python-pip jdk9-openjdk gradle
	@sudo pacman -S --needed --noconfirm texlive-most texlive-langjapanese poppler-data
	@sudo pacman -S --needed --noconfirm xf86-video-intel mesa xorg
	@sudo pacman -S --needed --noconfirm lightdm lightdm-gtk-greeter light-locker bspwm sxhkd
	@sudo pacman -S --needed --noconfirm pulseaudio pulseaudio-alsa pavucontrol pamixer
	@sudo pacman -S --needed --noconfirm fcitx-skk skk-jisyo fcitx-configtool
	@sudo pacman -S --needed --noconfirm feh w3m compton xcompmgr xorg-xkbcomp xsel
	@sudo pacman -S --needed --noconfirm rxvt-unicode firefox chromium keepassxc qpdfview
	@sudo pacman -S --needed --noconfirm numix-gtk-theme
	@sudo pacman -S --needed --noconfirm awesome-terminal-fonts otf-ipafont
	@if [ ! -f /usr/share/fonts/OTF/ipaexm.ttf ]; then packer -S otf-ipaexfont; fi
	@if [ ! -f /usr/share/fonts/TTF/GenShinGothic-Regular.ttf ]; then packer -S ttf-genshin-gothic; fi
	@if [ ! -f /usr/share/fonts/TTF/FiraMono-Regular.ttf ]; then packer -S fira-code; fi
	@if [ ! -f /usr/share/nvm/init-nvm.sh ]; then packer -S nvm; fi
	@if [ ! -f /usr/bin/envchain ]; then packer -S envchain; fi
	@if [ ! -f /usr/bin/cmus ]; then packer -S cmus-git; fi
	@if [ ! -f /usr/bin/yabar ]; then packer -S yabar-git; fi
	@if [ ! -f /usr/bin/cmigemo ]; then packer -S cmigemo-git; fi
	@if [ ! -f /usr/bin/xkeysnail ]; then sudo /usr/bin/pip3 install xkeysnail; fi
	@if [ ! -f ~/.config/fish/functions/fisher.fish ]; then \
	  echo 'Installing fisherman...' && \
	  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher; \
	fi
	@if [ ! -d ~/venv ]; then \
	  echo 'Creating ~/venv ...' && \
	  /usr/bin/python3 -m venv ~/venv && \
	  ~/venv/bin/pip3 install ranger-fm tw2.pygmentize && \
	  ranger --copy-config=all; \
	fi
	@if [ ! -f ~/.cargo/bin/rustup ]; then \
	  echo 'Installing rustup...' && \
	  wget https://sh.rustup.rs -o /tmp/rustup-init && \
	  sh /tmp/rustup-init -y --no-modify-path --default-toolchain stable && \
	  ~/.cargo/bin/cargo +stable install exa cargo-edit cargo-install && \
	  ~/.cargo/bin/cargo +nigthly install rustfmt-nightly; \
	fi
	@echo 'Enabling systemd units...'
	@sudo systemctl enable ntpd.service
	@sudo systemctl enable lightdm.service
endif
