
# Directory navigation
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'


alias ls='ls -alFhG'
alias lm='CLICOLOR_FORCE=1 ls -alFh | less -R'
alias l='ls -alFh'
alias ll='ls -alFh'

alias e="$EDITOR \$*"
alias m='more $*'

alias a="$EDITOR ~/.zsh-features/aliases.zsh"


# NPM Aliases
alias n='npm $*'
alias ni='npm install $*'
alias nr='npm run $*'
alias nrs='echo "$(tab_color_yellow)" && npm run start'
alias npmu='npm update $*'

# Maven Aliases
alias m='mvn $*'
alias mcc='mvn clean compile $*'
alias mcv='mvn clean verify $*'
alias mci='mvn clean install $*'
alias mcist='mvn -q clean install -DskipTests $*'
alias mt='mvn test $*'
alias mvv='mvn validate $*'
alias mvnv='mvn versions:set $*'
alias mvnvc='rm **/*.versionsBackup'

# Terraform Aliases
alias tf='terraform $*'
alias tfa='terraform apply $* && newSingleShotAnyBar green "Terraform Command Completed"'


# Cool Tools
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

alias java8='export JAVA_HOME=`/usr/libexec/java_home -v 1.8`'
alias java9='export JAVA_HOME=`/usr/libexec/java_home -vi 9`'
alias java11='export JAVA_HOME=`/usr/libexec/java_home -v 11`'
alias java12='export JAVA_HOME=`/usr/libexec/java_home -v 12`'

# Docker Aliases
alias dps='docker ps $*'
alias dr='docker $*'
alias drsrm='docker stop $1 && docker rm $1'

# Time / Task Warrior Aliases
alias tw='timew $*'
alias twt='timew track $*'
alias twsw='timew summary :week :ids $*'
alias twslw='timew summary :lastweek :ids $*'
alias twsm='timew summary :month :ids $*'
alias twslm='timew summary :lastmonth :ids $*'
alias twlw='timew week :lastweek $*'
alias twlm='timew month :lastmonth $*'


# Profile Aliases
alias pol='source ~/.membrane/environments/politie/environment.zsh'
alias yoink='source ~/.membrane/environments/yoink/environment.zsh'
