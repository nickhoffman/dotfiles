#!/bin/bash

if [ "`uname -s`" = "Darwin" ]; then
  # Needed for The Silver Searcher's Bash completion.
  shopt -s extglob

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

# if [[ -d `brew --prefix`/etc/bash_completion.d ]]; then
#   for file in `brew --prefix`/etc/bash_completion.d/*; do
#     echo "sourcing $file"
#     source $file
#   done
# fi
fi
