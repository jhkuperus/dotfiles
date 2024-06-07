# cd into a directory without typing cd
setopt auto_cd

# Complete inside of words
setopt complete_in_word

# If completion started inside a word, move to the end
setopt always_to_end

# Don't use #, ~ and ^ as patterns while globbing
unsetopt extendedglob

# Don't beep
unsetopt beep
