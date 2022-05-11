# Aliasses for different variations of ls
alias ls='exa --long --colour=always --header --git'
alias lm='exa --long --colour=always --header --git | less'
alias ll='exa -a --long --colour=always --header --git'
alias l='exa --long --colour=always --header --git'

alias e='$EDITOR'
alias m='more'

alias a='vi ~/.kramor_shell_profile'
alias ag='vi ~/.kramor_git_aliases'

alias pwdc='pwd|pbcopy'

alias httpd='python -m SimpleHTTPServer'

alias profile='vi ~/.bash_profile'
alias c='cd'

export GIT_LOG_OPTIONS="--pretty=format:\"%h, - %an, $ar : %s\" --graph"

# Cool Tools
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.arg[1])"'

