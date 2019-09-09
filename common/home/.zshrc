autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz select-word-style

export PROMPT='[%F{198}%~%f]%(?.. %B%F{009}(%?%)%f%b) %B$%b '

export HISTFILE=${HOME}/.zsh-history
export HISTSIZE=100000
export SAVEHIST=100000

setopt auto_cd
setopt auto_list
setopt auto_menu
setopt correct
setopt hist_ignore_dups
setopt inc_append_history
setopt interactivecomments
setopt list_packed
setopt list_types
setopt magic_equal_subst
setopt no_beep
setopt no_flow_control
setopt notify
setopt prompt_subst
setopt share_history

bindkey -e

select-word-style bash

eval "$(starship init zsh)"

# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr '%F{011}'
# zstyle ':vcs_info:git:*' unstagedstr '%F{009}'
# zstyle ':vcs_info:*' formats '%F{010}%c%u(%s)[%b] %m'
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# _vcs_precmd () { vcs_info }
# add-zsh-hook precmd _vcs_precmd
# export RPROMPT='%{${reset_color}%}${vcs_info_msg_0_}'
# zstyle ':vcs_info:*git+set-message:*' hooks git-config-user

# function +vi-git-config-user() {
#   hook_com[misc]+=`printf '%s(%s)' "$(git config user.name)" "$(git config user.email)"`
# }

if [ -f /usr/bin/apt ]; then
  alias awk='/usr/bin/gawk'
fi

if [ -f /usr/bin/envchain ] && [ -f /usr/bin/hub ]; then
  alias hub='/usr/bin/envchain github /usr/bin/hub'
fi

if [ -f ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh
  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-autosuggestions", defer:2
  zplug load
fi

function check-zplug() {
  if zplug check --verbose; then
    echo 'Up to date.'
  else
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
}

source ~/.profile

if [ -f ~/.travis/travis.sh ]; then
  source ~/.travis/travis.sh
fi
