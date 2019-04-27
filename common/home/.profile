export JAVA_HOME=/usr/lib/jvm/intellij-jdk
export _JAVA_AWT_WM_NONREPARENTING=1
export EDITOR=/usr/bin/vim

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts/local/sh:$PATH
export PATH=$HOME/scripts/sh:$PATH

if which pyenv > /dev/null 2>&1; then
  PYTHON_VERSION=3.7.2
  export PATH="$HOME/tools/python/$PYTHON_VERSION/ranger/bin:$PATH"
  export PATH="$HOME/tools/python/$PYTHON_VERSION/pygmentize/bin:$PATH"
  export PATH="$HOME/tools/python/$PYTHON_VERSION/ptpython/bin:$PATH"
  export PATH="$HOME/tools/python/$PYTHON_VERSION/pipenv/bin:$PATH"
  export PATH="$HOME/tools/python/$PYTHON_VERSION/oj/bin:$PATH"
  export PATH="$HOME/tools/python/$PYTHON_VERSION/http/bin:$PATH"
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
