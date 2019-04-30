#!/usr/bin/env bash

function installAllDotFiles() {
  echo "Here goes..."
  installFor "git-functions.zsh" "zsh-features"
  installFor "anybar-integration.zsh" "zsh-features"
  installFor "iterm2-shell-integration.zsh" "zsh-features"
  installFor "iterm2-custom-escape-codes.zsh" "zsh-features"
  installFor "timewarrior-helpers.zsh" "zsh-features"
  scriptFor "vim"
  installFor "vimrc"
  installFor "gitignore"
  installFor "gitconfig"
  installFor "kramor_git_aliases"
  installFor "karabiner.json" "config/karabiner"
  # installFor "git"
  # scriptFor "wtvr"

  installFor "app-management.lua" "hammerspoon"
  installFor "caffeine.lua" "hammerspoon"
  installFor "emoji.lua" "hammerspoon"
  installFor "hyper.lua" "hammerspoon"
  installFor "init.lua" "hammerspoon"
  installFor "modal-tools.lua" "hammerspoon"
  installFor "window-management.lua" "hammerspoon"
}


PWD=$(pwd)
HOME=$(cd && pwd)

## $1 = FILE
## $2 = LOCATION (default: '', if defined, file will be loaded from path and linked to same path in $HOME, prepended with a '.')
function installFor() {
  if [[ -z "$1" ]]; then
    echo "Cannot invoke installFor without arguments"
    return
  fi

  FILE=$1

  if [[ -z "$2" ]]; then
    FROM=$PWD/.$FILE
    TO=$HOME/.$FILE
  else
    LOCATION=$2

    FROM=$PWD/$LOCATION/$FILE
    TO=$HOME/.$LOCATION/$FILE

    mkdir -p $HOME/.$LOCATION
  fi

  if [[ -e "$FROM" ]]; then
    echo "Linking $FROM to $TO..."
    rm $TO 2> /dev/null
    ln -s $FROM $TO
  else
    echo "WARNING: Missing dotfile for $FROM"
  fi
}

## $1 = Subdir containing install.sh script
function scriptFor() {
  TARGET_SCRIPT=$PWD/$1/install.sh
  if [[ -e $TARGET_SCRIPT ]]; then
    echo "Installing $1..."
    . $TARGET_SCRIPT
  else
    echo "WARNING: Missing install script for $1 ($TARGET_SCRIPT)"
  fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  installAllDotFiles
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    installAllDotFiles
  fi
fi
