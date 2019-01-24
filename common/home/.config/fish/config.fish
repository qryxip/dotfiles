set fish_greeting
set fish_prompt_pwd_dir_length 0
set fish_ambiguous_width 1
set fish_emoji_width 2

function fish_prompt
  set last_status $status
  set_color 5fff87 # 84
  # printf '%s@%s' (whoami) (hostname)
  if [ -n "$RANGER_LEVEL" ]
    printf '(ranger) '
  end
  set_color normal
  printf '['
  set_color ff0087 # 198
  printf '%s' (prompt_pwd)
  set_color normal
  printf ']'
  if [ "$last_status" -ne 0 ]
    set_color --bold ff0000
    printf ' (%s)' $last_status
    set_color normal
  end
  set_color --bold
  printf ' $ '
  set_color normal
end

function ll
  if [ -d /c/Windows ]
    ls -l $argv
  else
    /usr/bin/env ll $argv
  end
end

function r
  ranger $argv
end
