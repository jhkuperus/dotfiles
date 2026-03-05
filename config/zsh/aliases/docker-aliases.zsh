# Docker Aliases
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dps='docker ps'
alias dr='docker'
alias drsrm='docker stop $1 && docker rm $1'
alias drprune='docker image prune -af'


alias ad='vi ~/dotfiles/config/zsh/aliases/docker-aliases.zsh && source ~/dotfiles/config/zsh/aliases/docker-aliases.zsh'
