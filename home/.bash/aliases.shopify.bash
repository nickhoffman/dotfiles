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
fi

# End Mac OS X section.
##########
