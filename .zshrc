export LANG=ja_JP.UTF-8
export PROMPT='%F{green}%~%f $ '

setopt auto_cd
setopt auto_list
setopt auto_menu
setopt correct
setopt no_beep
setopt list_packed
setopt list_types
setopt magic_equal_subst
setopt no_flow_control
setopt notify

autoload -Uz colors; colors
autoload -Uz compinit; compinit
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}'
zstyle ':vcs_info:*' formats '%F{green}%c%u(%s)[%b] %m'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
_vcs_precmd () { vcs_info }
add-zsh-hook precmd _vcs_precmd
export RPROMPT='%{${reset_color}%}${vcs_info_msg_0_}'
zstyle ':vcs_info:*git+set-message:*' hooks git-config-user

function +vi-git-config-user() {
    hook_com[misc]+=`printf '%s(%s)' "$(git config user.name)" "$(git config user.email)"`
}

