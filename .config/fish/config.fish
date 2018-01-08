set fish_greeting
set fish_prompt_pwd_dir_length 0
export LD_LIBRARY_PATH=(rustup run nightly rustc --print sysroot)/lib

function fish_prompt
  set_color 5fff87 # 84
  printf '%s@%s' (whoami) (hostname)
  set_color ff0087 # 198
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

function r
  ranger $argv
end

