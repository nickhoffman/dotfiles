##########
# Begin Mac OS X section.

if [ "`uname`" = 'Darwin' ]; then
  # Forward a local port to Vagrant.
  function forward_to_vagrant {
    port="$1"

    if [ -z "$port" ]; then
      echo 'Which port do you want to foward?'
      return 1
    fi

    echo "Forwarding port $port to Vagrant."
    echo "Hit Ctrl+C to cancel."

    cd ~/src/vagrant/
    vagrant ssh -- -N -L $port:localhost:$port
  }

  # Update Vagrant.
  alias update_vagrant='cd ~/src/vagrant/ && git pull origin master && vagrant up && vagrant provision'

  ##########
  # Begin functions for swapping between using Shopify production and app4.

  function _chbrochure_resolve() {
    resolveip $1 | awk '{ print $6 }'
  }

  function _chbrochure_host() {
    case $1 in
    app4)
      echo 'brochure-app4.ec2.shopify.com'
      ;;
    production)
      echo 'origin.www.shopify.com'
      ;;
    staging)
      echo 'brochure.staging.shopify.io'
      ;;
    *)
      echo $1
      ;;
    esac
  }

  function _chbrochure_set() {
    local _temphosts=`mktemp -t chbrochure.hosts`

    cat /etc/hosts | sed -e "/brochure2-hosts-start/,/brochure2-hosts-end/d" >$_temphosts

    if [ "$1" != "production" ]
    then
      local _host=`_chbrochure_host $1`
      local _ip=`_chbrochure_resolve $_host | head -n1`

      shift

      cat >>$_temphosts <<HOSTS
## brochure2-hosts-start
$_ip  www.shopify.com www.shopify.ca www.shopify.co.ng www.shopify.co.nz www.shopify.co.uk www.shopify.co.za www.shopify.com.au www.shopify.in www.shopify.my es.shopify.com fr.shopify.ca fr.shopify.com pt.shopify.com wholesale.shopify.com $*
## brochure2-hosts-end
HOSTS
    fi

    sudo cp $_temphosts /etc/hosts
    rm -f $_temphosts
  }

  function _chbrochure_which() {
    local _ip=`_chbrochure_resolve www.shopify.com | head -n1`

    for _env in app4 production staging
    do
      _chbrochure_resolve `_chbrochure_host $_env` | grep -q $_ip
      echo "`echo $? | tr '01' '* '` $_env"
    done
  }

  function chbrochure() {
    if [ $# -eq 0 ]
    then
      _chbrochure_which
    else
      _chbrochure_set $*
    fi
  }

  # End functions for swapping between using Shopify production and app4.
  ##########
fi

# End Mac OS X section.
##########
