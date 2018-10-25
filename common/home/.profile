export JAVA_HOME=/usr/lib/jvm/intellij-jdk
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=kde
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=/usr/bin/vim

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/venvs/http/bin:$PATH
export PATH=$HOME/venvs/pygmentize/bin:$PATH
export PATH=$HOME/venvs/ranger/bin:$PATH
export PATH=$HOME/venvs/playground/bin:$PATH
export PATH=$HOME/.gem/ruby/2.5.0/bin:$PATH
export PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts/local/sh:$PATH
export PATH=$HOME/scripts/sh:$PATH

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

eval `opam env`

if ! pidof emacs > /dev/null; then
  emacs --daemon || true &
fi
