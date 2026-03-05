# Aliasses for different variations of ls
alias ls='eza --long --colour=always --header --git'
alias lm='eza --long --colour=always --header --git | less'
alias ll='eza -a --long --colour=always --header --git'
alias l='eza --long --colour=always --header --git'

alias du=dust

alias e='$EDITOR'
alias m='more'

alias a='vi ~/dotfiles/config/zsh/aliases/generic-aliases.zsh'
alias ag='vi ~/dotfiles/config/zsh/aliases/git-aliases.zsh'
alias ar='for af in ~/.config/zsh/aliases/*; do source $af; done'

alias pwdc='pwd|pbcopy'

alias httpd='python3 -m http.server'

alias profile='vi ~/.bash_profile'
alias c='cd'

# Aliasing npm to pnpm for safety!
alias npm=pnpm

export GIT_LOG_OPTIONS="--pretty=format:\"%h, - %an, $ar : %s\" --graph"

# Set NeoVim as default vim editor
alias vi='nvim'
alias vim='nvim'

# Cool Tools
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.arg[1])"'

# Navigation helps
alias -g ...=cd ../..
alias -g ....=cd ../../..
alias -g .....=cd ../../../..
alias -g ......=cd ../../../../..
alias -g .......=cd ../../../../../..

# Disk Usage analysis
alias du1='du -d 1'
alias dfh='df -h'
