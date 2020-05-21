export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export _JAVA_AWT_WM_NONREPARENTING=1
export EDITOR=/usr/bin/vim

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts/local/sh:$PATH
export PATH=$HOME/scripts/bash:$PATH
export PATH=$HOME/scripts/sh:$PATH
export PATH=$HOME/scripts/py:$PATH

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

if command -v pyenv > /dev/null 2>&1; then
  PYTHON_VERSION=3.8.2
  for dir in ~/tools/python/$PYTHON_VERSION/*/bin; do
    export PATH="$dir:$PATH"
  done
  eval "$(pyenv init -)"
fi

p=1
if which npm > /dev/null 2>&1; then
  if which npm | grep ~ > /dev/null; then
    p=0
  fi
fi

if [ $p = 1 -a -f /usr/share/nvm/init-nvm.sh ]; then
  . /usr/share/nvm/init-nvm.sh
  nvm use --lts
fi

if command -v node > /dev/null 2>&1; then
  node_version=$(node --version)
  for dir in ~/tools/node/"$node_version"/*/node_modules/.bin; do
    export PATH="$dir:$PATH"
  done
fi

if [ -f ~/.cargo/env ]; then
  . ~/.cargo/env
fi

if command -v opam > /dev/null 2>&1; then
  eval "$(opam env)"
fi

echo '{"rules":{}}' > /tmp/.textlintrc
