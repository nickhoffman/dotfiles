if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

export GOPATH="$HOME/src/go"
export PATH=$PATH:$GOPATH/bin
