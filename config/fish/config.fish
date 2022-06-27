if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH /usr/local/bin:$PATH

set HOMEBREW /opt/homebrew/bin/brew
if test -f $HOMEBREW 
  eval $($HOMEBREW shellenv)
end

starship init fish | source

# Load aliases from dotfiles
for file in ~/.zsh-features/aliases/*
  source $file
end

