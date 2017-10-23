set fish_greeting
set fish_prompt_pwd_dir_length 0

alias nvm='zsh -c "nvm"'

function fish_prompt
  set_color 1564a1
  printf '%s@%s' (whoami) (hostname)
  set_color f92672
  printf ' %s' (prompt_pwd)
  set_color normal
  printf ' $ '
end

function ll
  /usr/bin/env ls -l -h --color=auto $argv
end

function e
  /usr/bin/env emacsclient -n $argv
end

function en
  /usr/bin/env emacsclient -nw -a '' $argv
end

function emacs
  /usr/bin/env emacsclient -n $argv
end

function emacs-nw
  /usr/bin/env emacsclient -nw -a "" $argv
end
