#!/bin/bash

# Homebrew, high priority
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

# NPM, low priority
if [ -d /usr/local/share/npm/bin ]; then
  export PATH=$PATH:/usr/local/share/npm/bin
fi