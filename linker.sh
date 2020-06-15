#!/bin/bash
# Links everything in home/ to ~/, does sanity checks.
# By Simon Eskildsen (github.com/Sirupsen)

function symlink {
  ln -nsf $1 $2
}

if [[ ! -d /usr/local/bin ]]; then
  echo 'ERROR: Directory /usr/local/bin does not exist.'
  exit 1
fi

echo '### Installing personal config files'
for file in home/.[^.]*; do
  path="$(pwd)/$file"
  base=$(basename $file)
  target="$HOME/$(basename $file)"

  if [[ -h $target && ($(readlink $target) == $path)]]; then
    echo -e "\x1B[90m~/$base is symlinked to your dotfiles.\x1B[39m"
  elif [[ -f $target && $(md5sum $path) == $(md5sum $target) ]]; then
    echo -e "\x1B[32m~/$base exists and was identical to your dotfile.  Overriding with symlink.\x1B[39m"
    symlink $path $target
  elif [[ -a $target ]]; then
    read -p "\x1B[33m~/$base exists and differs from your dotfile. Override?  [yn]\x1B[39m" -n 1

    if [[ $REPLY =~ [yY]* ]]; then
      symlink $path $target
    fi
  else
    echo -e "\x1B[32m~/$base does not exist. Symlinking to dotfile.\x1B[39m"
    symlink $path $target
  fi
done
echo

echo '### Installing personal programs'
for file in bin/*; do
  usr_local_bin="/usr/local/bin"
  path="$(pwd)/$file"
  base=$(basename $file)
  target="$usr_local_bin/$(basename $file)"

  if [[ -h $target && ($(readlink $target) == $path)]]; then
    echo -e "\x1B[90m~/$base is symlinked to $usr_local_bin.\x1B[39m"
  elif [[ -f $target && $(md5sum $path) == $(md5sum $target) ]]; then
    echo -e "\x1B[32m~/$base exists and was identical to $usr_local_bin.  Overriding with symlink.\x1B[39m"
    symlink $path $target
  elif [[ -a $target ]]; then
    read -p "\x1B[33m~/$base exists and differs from $usr_local_bin. Override?  [yn]\x1B[39m" -n 1

    if [[ $REPLY =~ [yY]* ]]; then
      symlink $path $target
    fi
  else
    echo -e "\x1B[32m~/$base does not exist. Symlinking to $usr_local_bin.\x1B[39m"
    symlink $path $target
  fi
done
