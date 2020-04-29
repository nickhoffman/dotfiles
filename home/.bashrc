#!/bin/bash 

for file in ~/.bash/*.bash; do
  source $file
done

export PATH="$PATH:$HOME/Library/Python/3.7/bin"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi

# If not inside of tmux, use the newest version of Ruby that's installed.
if [ -z "$TMUX" ]; then
  type chruby | grep -q 'is a function'
  if [ "$?" -eq "0" ]; then
    newest_version=`chruby | tail -1 | tr -d '[:space:]'`
    echo "Using Ruby version ${newest_version}"
    chruby "$newest_version"
  fi
fi

export PATH="$HOME/.yarn/bin:$PATH"

# Disable Mac OS' deprecation warning of Bash.
export BASH_SILENCE_DEPRECATION_WARNING=1
