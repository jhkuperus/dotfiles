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
sudo xcodebuild -license accept

# Check if Homebrew is installed and install if it is missing
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew
brew update

# Using Brew Bundle to generate and install a Brewfile containing all installed apps
#
# Note when preparing a new wipe: make sure brew bundle dump generates all newly installed
# brews/taps/casks/etc
brew tap homebrew/bundle
brew bundle install --no-upgrade --file=$PWD/cleanInstall/Brewfile

# Make Fish the default shell environment
FISH_SHELL=$(which fish)
if grep "$FISH_SHELL" /etc/shells > /dev/null;
then
  echo "Fish is available as shell"
else
  echo "Fish is not available as shell, correcting"
  sudo sh -c "echo '$FISH_SHELL' >> /etc/shells"
fi

chsh -s $(which fish)

# Install global NPM packages
# Use this command to check for globally installed packages: npm list -g --depth 0
npm install --global @angular/cli npmrc reveal-md typescript


# Enable atrun daemon to use the `at` command
launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist

# Install Fira Nerd Fonts
echo "Installing Fira Nerd Fonts"
cp $PWD/cleanInstall/fonts/* /Library/Fonts


# Installing SDKMAN!
curl -s "https://get.sdkman.io" | bash



# Final manual steps
echo There are a few final steps that require manual intervention
echo "+ Hammerspoon"
echo "  > Please download Hammerspoon from https://github.com/Hammerspoon/hammerspoon/releases/latest"
echo "  > Then move the application to /Applications/"
echo "+ AirPlay Receiver"
echo "  > Go to Preferences -> Sharing and turn AirPlay Receiver off"
echo "  > Leaving it on will drastically reduce BT sound quality with multiple devices connected"
echo ""
echo "Don't forget to install dotfiles and dotfiles_private!"

