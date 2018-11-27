#!/usr/bin/env bash

function installAllDotFiles() {
  echo "Here goes..."
  # installFor "git"
  # scriptFor "wtvr"
}


PWD=$(pwd)
HOME=$(cd && pwd)

## $1 = FROM
## $2 = TO (default: $FROM)
## $3 = IN ( ? )
function installFor() {
  if [[ -z "$1" ]]; then
    echo "Cannot invoke installFor without arguments"
    return
  fi

  FROM=$1

  if [[ -n "$2" ]]; then
    TO=$FROM
  else
    TO=$2
  fi

  if [[ -n "$3" ]]; then
    echo "What am I doing?"
    mkdir -p ./"$3"
  fi

  if [[ -e $PWD/$FROM ]]; then
    echo "Linking $FROM to $HOME/$TO..."
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
