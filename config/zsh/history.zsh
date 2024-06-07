HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Don't save duplicates
HISTDUP=erase
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Ignore common commands
HISTORY_IGNORE="(ls|cd|pwd|exit)*"

# Append to histfile, don't overwrite
setopt append_history

# Immediately append to histfile, don't wait for shell to exit
setopt inc_append_history

# Share history between open sessions
setopt share_history

# Ignore commands preceded with a space, to prevent secrets from being saved
setopt hist_ignore_space

# Remove unnecessary whitespace
setopt hist_reduce_blanks
