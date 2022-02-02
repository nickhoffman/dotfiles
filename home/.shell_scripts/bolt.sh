#! /bin/sh

if [[ -f ~/.bolt ]]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"

  export WORKSPACE_DIR=~/src
  export BOLTUSR=nhoffman                         # first part of your bolt email
  export BL_EMAIL=$BOLTUSR@bolt.com               # your bolt email
  export BL_DOMAIN=$BOLTUSR                       # where your local processes can be reached: eg. admin.$BL_DOMAIN.bolt.me

  # golang development
  export GOENV=development
  export GO111MODULE=auto
  export GOPROXY=https://proxy.golang.org
  export PATH=$PATH:$HOME/go/bin                  # this adds golang binaries to your path

  # running localdev
  export PGUSER=postgres                          # For postgres setup later
  export PGPASSWORD=test
  export BL_NGROK="22NwNXqFSgaZheRJle8G0vHQO1h_79F2Vsob8SdW71RAcVPRW"
  export COMPOSE_PROFILES=elasticmq,redis,elasticsearch

  alias awslogin='saml2aws login --force --role="arn:aws:iam::646669275451:role/User-GeneralEngineering" --username=nhoffman@bolt.com'

  alias cdld='cd $WORKSPACE_DIR/source/hail/tools/localdev'
fi
