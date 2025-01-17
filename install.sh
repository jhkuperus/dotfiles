#!/usr/bin/env bash

UNAME_OUTPUT=$(uname -s)
case "$UNAME_OUTPUT" in
  Linux*)   OS=LINUX;;
  Darwin*)  OS=DARWIN;;
  *)        OS=UNSUPPORTED;;
esac

if [[ $OS == "UNSUPPORTED" ]];
then
  echo "Sorry, this OS is not supported at this time: $OS"
  exit 1
fi

echo "Detected Operating System: $OS"

function installAllDotFiles() {
  echo "Here goes..."
  installFor "zshenv"
  installFor "zsh" "config"
  installFor "nvim" "config"

  # Temporary "hack", need to make this fit the rest of the dotfiles-philosophy
  if [[ -d ~/dotfiles_private/config/zsh/aliases ]]; then
    for pa in ~/dotfiles_private/config/zsh/aliases/*; do
      PAF=$(basename $pa)
      ln -s ~/dotfiles_private/config/zsh/aliases/$PAF ~/.config/zsh/aliases/private_$PAF
    done
  fi

  installFor "p10k.zsh"
  scriptFor "vim"
  installFor "vimrc"
  installFor "gitignore"
  installFor "gitconfig"

  if [[ $OS == "DARWIN" ]];
  then
    installFor "karabiner.json" "config/karabiner"

    installFor "app-management.lua" "hammerspoon"
    installFor "caffeine.lua" "hammerspoon"
    installFor "double-shift.lua" "hammerspoon"
    installFor "emoji.lua" "hammerspoon"
    installFor "hyper.lua" "hammerspoon"
    installFor "init.lua" "hammerspoon"
    installFor "modal-tools.lua" "hammerspoon"
    installFor "window-management.lua" "hammerspoon"
  fi

  installFor "gpg-agent.conf" "gnupg"
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
