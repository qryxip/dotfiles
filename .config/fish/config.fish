set --erase FISH_GREETING

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_char_dirtystate '!'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles 'Z'
set __fish_git_prompt_char_stashstage '←'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_behind '-'

function fish_prompt
  set_color f92672
  printf '%s' (pwd)
  set_color normal
  printf '%s' (__fish_git_prompt)
  set_color normal
  printf ' $ '
end

function ls
  /usr/bin/env ls -l -h --color=auto $argv
end

function cdls
  cd $argv[1]
  /usr/bin/env ls -l -h --color=auto
end

function cdlsa
  cd $argv[1]
  /usr/bin/env ls -la -h --color=auto
end

function v
  /usr/bin/env nvim $argv
end

function vi
  /usr/bin/env nvim $argv
end

function vim
  /usr/bin/env nvim $argv
end

function e
  /usr/bin/env emacsclient -n $argv
end

function emacs
  /usr/bin/env emacsclient -n $argv
end

function emacs-nw
  /usr/bin/env emacsclient -nw -a "" $argv
end
