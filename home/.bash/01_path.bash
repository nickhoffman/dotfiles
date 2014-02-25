#!/bin/bash

# Homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# NPM
if [ -d /usr/local/share/npm/bin ]; then
  export PATH=$PATH:/usr/local/share/npm/bin
fi

# Personal bin files
if [[ -d $HOME/.bin ]]; then
  export PATH=$PATH:$HOME/.bin
fi

if [[ -n $SHOPIFY_DEV_VAGRANT ]]; then
  export GOPATH=~/src/go
else
  export GOPATH=~/code/go
fi

# Use gnu utils instead of os x
if [[ -d /usr/local/opt/coreutils/libexec/gnubin ]]; then
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" 
fi

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion" 
