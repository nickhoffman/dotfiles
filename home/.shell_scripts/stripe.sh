/bin/hostname | grep -q 'st-hoffman'
if [[ "x$?" = 'x0' ]]; then
  export GH_HOST="git.corp.stripe.com"

  autoload -Uz compinit; compinit
  autoload -Uz bashcompinit; bashcompinit
  source ~/.bash_profile
  source ~/.bashrc
  eval "$(nodenv init -)"
  compdef _git stripe-git=git # this line specifically will fix git autocompletion

  export GOPATH="/Users/hoffman/go"
fi
