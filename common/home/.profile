export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export _JAVA_AWT_WM_NONREPARENTING=1
export EDITOR=/usr/bin/vim

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts/local/sh:$PATH
export PATH=$HOME/scripts/sh:$PATH

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

if which pyenv > /dev/null 2>&1; then
  PYTHON_VERSION=3.8.0
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
  source /usr/share/nvm/init-nvm.sh
  nvm use --lts
fi

if which node > /dev/null 2>&1; then
  node_version=$(node --version)
  export PATH="$HOME/tools/node/$node_version/typescript/node_modules/.bin:$PATH"
  export PATH="$HOME/tools/node/$node_version/textlint/node_modules/.bin:$PATH"
fi

if [ -f ~/.cargo/env ]; then
  source ~/.cargo/env
fi

if which opam > /dev/null 2>&1; then
  eval $(opam env)
fi

echo '{"rules":{}}' > /tmp/.textlintrc
