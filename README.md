Contains all my dotfiles 🍩 😇

Use `install.sh` to automatically setup all of these files in your homedir. 



Credits: installer was inspired by jqno's dotfiles (https://github.com/jqno/dotfiles)




### Ideas yet to make

* Distraction Free mode (block all but active screen)
* tomato timer


### Things to do

* Add Brewfile to install my Brew-apps
  * Add LuLu to Brewfile
      * Add Bartender
      * Add Oversigh



# Import Procedures to Remember

This section contains some tricks I found around the internet and want to keep around.


## Disable SIP

1. Reboot into Recovery mode (Hold ⌘-R)
2. Open Terminal
3. Execute `csrutil disable`
4. Reboot

## Enable SIP

1. Reboot into Recovery mode (Hold ⌘-R)
2. Open Terminal
3. Execute `csrutil enable`
4. Reboot

## Disable Automatic Gamma Correction

1. Disable SIP
2. Disable "Auto Brightness" (Preferences -> Displays)
3. `cd /System/Library/PrivateFrameworks/AmbientDisplay.framework/Versions/A/XPCServices/com.apple.AmbientDisplayAgent.xpc/Contents/MacOS/`
4. `mv com.apple.AmbientDisplayAgent _com.apple.AmbientDisplayAgent`
5. Enable SIP and reboot
6. Enable "Auto Brightness"


