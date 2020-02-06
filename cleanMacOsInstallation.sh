#!/bin/sh

set PWD=$(pwd)

echo "Please be aware this script should only be run on a clean install of MacOS"
echo "It will download and install a lot of applications and run for quite a while"
echo ""
echo -n "Are you sure you wish to continue?"

select READY in "Yes" "No"; do
  case $READY in
    Yes ) echo "Cool, go get some coffee then, or read a book"; break;;
    No ) echo "Ok, aborting."; exit;;
  esac
done

echo ""

# Make sure XCode and tools have been installed
xcode-select --install

# Check if Homebrew is installed and install if it is missing
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew
brew update

# Using Brew Bundle to generate and install a Brewfile containing all installed apps
#
# Note when preparing a new wipe: make sure brew bundle dump generates all newly installed
# brews/taps/casks/etc
brew tap homebrew/bundle
brew bundle install --no-upgrade --file=$PWD/cleanInstall/Brewfile

# Make ZSH the default shell environment
chsh -s $(which zsh)

# Install global NPM packages
# Use this command to check for globally installed packages: npm list -g --depth 0
npm install --global @angular/cli npmrc phantomjs-prebuilt reveal-md typescript


# Enable atrun daemon to use the `at` command
launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist
