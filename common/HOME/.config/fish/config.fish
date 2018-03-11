set fish_greeting
set fish_prompt_pwd_dir_length 0
export LD_LIBRARY_PATH=(rustup run nightly rustc --print sysroot)/lib

function fish_prompt
  set last_status $status
  set_color 5fff87 # 84
  printf '%s@%s' (whoami) (hostname)
  if [ -n "$RANGER_LEVEL" ]
    printf ' (ranger)'
  end
  set_color normal
  printf ' ['
  set_color ff0087 # 198
  printf '%s' (prompt_pwd)
  set_color normal
  printf ']'
  if [ "$last_status" -ne 0 ]
    printf ' (%s)' $last_status
  end
  printf ' $ '
end

function ll
  if [ -d /c/Windows ]
    ls -l $argv
  else
    /usr/bin/env ll $argv
  end
end

function e
  emacsclient -n $argv
end

function en
  emacsclient -nw -a '' $argv
end

function r
  ranger $argv
end
