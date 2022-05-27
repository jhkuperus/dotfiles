if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Load aliases from dotfiles
for file in ~/.zsh-features/aliases/*
  source $file
end

