set --erase FISH_GREETING

#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showuntrackedfiles 'yes'
#set __fish_git_prompt_showupstream 'yes'
#set __fish_git_prompt_char_dirtystate '!'
#set __fish_git_prompt_char_stagedstate '→'
#set __fish_git_prompt_char_untrackedfiles 'Z'
#set __fish_git_prompt_char_stashstage '←'
#set __fish_git_prompt_char_upstream_ahead '+'
#set __fish_git_prompt_char_behind '-'

function fish_prompt
  set_color green
  printf '%s' (pwd)
  set_color normal
  printf '%s' (__fish_git_prompt)
  set_color normal
  printf ' $ '
end

function ls
  /usr/bin/ls -l $argv
end

function lsa
  /usr/bin/ls -la $argv
end

function cdls
  cd $argv[1]
  /usr/bin/ls -l
end
