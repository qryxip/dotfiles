export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export _JAVA_AWT_WM_NONREPARENTING=1
export EDITOR=/usr/bin/vim

export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
export VOLTA_HOME="$HOME/.volta"

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts/local/sh:$PATH
export PATH=$HOME/scripts/bash:$PATH
export PATH=$HOME/scripts/sh:$PATH
export PATH=$HOME/scripts/py:$PATH
export PATH="$VOLTA_HOME/bin:$PATH"

if [ -e /usr/share/vulkan/icd.d/intel_icd.x86_64.json ]; then
  export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json
fi

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

if command -v pyenv > /dev/null 2>&1; then
  PYTHON_VERSION=3.8.6
  if [ -d ~/tools/python/"$PYTHON_VERSION" ]; then
    for dir in ~/tools/python/$PYTHON_VERSION/*/bin; do
      export PATH="$dir:$PATH"
    done
  fi
  eval "$(pyenv init --path)"
fi

if command -v node >/dev/null 2>&1; then
  node_version="$(node --version)"
  if [ -d ~/tools/node/"$node_version" ]; then
    for dir in ~/tools/node/"$node_version"/*/node_modules/.bin; do
      export PATH="$dir:$PATH"
    done
  fi
fi

#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
#
#if command -v node > /dev/null 2>&1; then
#  node_version=$(node --version)
#  if [ -d ~/tools/node/"$node_version" ]; then
#    for dir in ~/tools/node/"$node_version"/*/node_modules/.bin; do
#      export PATH="$dir:$PATH"
#    done
#  fi
#fi

if [ -f ~/.cargo/env ]; then
  . ~/.cargo/env
fi

if command -v opam > /dev/null 2>&1; then
  eval "$(opam env)"
fi

echo '{"rules":{}}' > /tmp/.textlintrc
