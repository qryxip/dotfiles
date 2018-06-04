export JAVA_HOME=/usr/lib/jvm/intellij-jdk
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=kde
export XDG_CONFIG_HOME=$HOME/.config
export PATH=$HOME/scripts/local/sh:$HOME/scripts/sh:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/venv/bin:$HOME/.gem/ruby/2.5.0/bin:$PATH
if [ -f ~/.ghq/github.com/KKPMW/dircolors-moonshine/dircolors.moonshine ]; then
  eval `dircolors ~/.ghq/github.com/KKPMW/dircolors-moonshine/dircolors.moonshine`
fi
source /usr/share/nvm/init-nvm.sh
nvm use --lts
