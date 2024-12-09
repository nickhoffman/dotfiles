#!/bin/bash
# Links everything in home/ to ~/, does sanity checks.
# By Simon Eskildsen (github.com/Sirupsen)

function symlink {
  ln -nsf $1 $2
}

# START: Prerequisites

if [[ ! -d /usr/local/bin ]]; then
  echo 'ERROR: Directory /usr/local/bin/ must exist and be writable.'
  exit 1
fi

if [[ ! -w /usr/local/bin ]]; then
  echo 'ERROR: You must be able to write to /usr/local/bin/'
  exit 1
fi

which brew 2>/dev/null
if [[ $? -ne 0 ]]; then
  echo 'ERROR: Install Homebrew and re-run this.'
  exit 1
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
  echo 'ERROR: Install oh-my-zsh and re-run this.'
  exit 1
fi

# END: Prerequisites

# START: Install 3rd-party software.

echo '### Setting up Git submodules'
git submodule init
git submodule update
echo

echo '### Installing Homebrew packages'
brew install `paste -s -d ' ' home/.homebrew_packages_to_install`
echo

echo '### Installing Ruby'
asdf plugin add ruby
asdf plugin-update ruby
asdf install ruby latest
asdf global ruby latest
echo

echo '### Installing Ruby gems'
gem install `paste -s -d ' ' home/.ruby_gems_to_install`
echo

# END: Install 3rd-party software.

# START: Install personal stuff.

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

echo '### Running personal config commands'
# Enable key repeating in VS Code by disabling key press-and-hold in VS Code.
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false
defaults write com.vscodium ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false

# END: Install personal stuff.
