#!/bin/bash

if [ "`uname -s`" = "Darwin" ]; then
  # Needed for The Silver Searcher's Bash completion.
  shopt -s extglob
fi

if [[ -d /usr/local/etc/bash_completion.d ]]; then
  for file in /usr/local/etc/bash_completion.d/*; do
    source $file
  done
fi

#if [[ -d /etc/bash_completion.d ]]; then
#  for file in /etc/bash_completion.d/*; do
#    source $file
#  done
#fi
