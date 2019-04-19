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

base=$(realpath $(dirname $0))

echo "${bold}Creating directories...${ansi_reset}"
mkdir -p ~/.vim ~/.emacs.d/straight ~/.config/alacritty ~/.config/cmus ~/.config/fish ~/.config/ranger/colorschemes
case "$(uname -s)" in
  Linux*)  mkdir -p ~/".config/Code - OSS/User";;
  Darwin*) mkdir -p ~/"Library/Application Support/Code/User";;
esac

echo "${bold}Creating symlinks...${ansi_reset}"
for name in .eslintrc .gitconfig .gvimrc .ideavimrc .latexmkrc .profile .tern-config .tigrc .tmux.conf .vimrc .zshrc; do
  ln -sf $base/common/home/$name ~/
done
ln -sf $base/common/home/.emacs.d/init.el ~/.emacs.d/
ln -sf $base/common/home/.emacs.d/el ~/.emacs.d/
ln -sf $base/common/home/.emacs.d/elisp ~/.emacs.d/
ln -sf $base/common/home/.emacs.d/snippets ~/.emacs.d/
ln -sf $base/common/home/.emacs.d/straight/versions ~/.emacs.d/straight/
ln -sf $base/common/home/.config/nvim ~/.config/
ln -sf $base/common/home/.config/alacritty/alacritty.yml ~/.config/alacritty/
ln -sf $base/common/home/.config/cmus/rc ~/.config/cmus/
ln -sf $base/common/home/.config/fish/config.fish ~/.config/fish/
ln -sf $base/common/home/.config/ranger/rc.conf ~/.config/ranger/
ln -sf $base/common/home/.config/ranger/colorschemes/mytheme.py ~/.config/ranger/colorschemes/
ln -sf $base/common/home/.vim/snippets ~/.vim/
for file in keybindings.json settings.json; do
 case "$(uname -s)" in
   Linux*)  ln -sf "$base/common/home/.config/Code - OSS/User/$file" ~/".config/Code - OSS/User/";;
   Darwin*) ln -sf "$base/common/home/.config/Code - OSS/User/$file" ~/".config//Library/Application Support/Code/User/";;
 esac
done

if [ -d ~/scripts/.git ]; then
  echo "${bold}qryxip/scripts already cloned.${ansi_reset}"
else
  git clone 'https://github.com/qryxip/scripts' ~/scripts
fi

if [ -d ~/.vim/dein.vim/.git ]; then
  echo "${bold}Shougo/dein.vim already cloned.${ansi_reset}"
else
  git clone 'https://github.com/Shougo/dein.vim' ~/.vim/dein.vim
fi

if [ ! -d ~/.zplug -a -f /usr/bin/zsh ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  echo "${bold}zplug already installed.${ansi_reset}"
fi

if [ -f ~/.config/fish/functions/fisher.fish ]; then
  echo "${bold}fisherman already installed.${ansi_reset}"
else
  echo "${bold}Installing fisherman...${ansi_reset}"
  curl https://git.io/fisher -Lo ~/.config/fish/functions/fisher.fish --create-dirs
fi
