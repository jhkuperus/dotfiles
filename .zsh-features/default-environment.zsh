
# Directory Navigation uses pushd by default
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# History Settings
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt hist_expire_dups_first
setopt appendhistory

unsetopt menu_complete flow_control
setopt auto_menu complete_in_word always_to_end

setopt autocd nomatch
unsetopt beep extendedglob notify


export PATH="/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:$PATH"

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

export EDITOR=/usr/local/bin/vi

# Colors and Appearance

autoload -U colors && colors
autoload -U select-word-style
select-word-style bash  

export LSCOLORS="Gxfxcxdxbxegedabagacad"

export RED="%{$fg_bold[red]%}"
export GREEN="%{$fg_bold[green]%}"
export YELLOW="%{$fg_bold[yellow]%}"
export CYAN="%{$fg_bold[cyan]%}"
export MAGENTA="%{$fg_bold[magenta]%}"
export WHITE="%{$fg_bold[white]%}"


# Completions
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
# Case-insensitive completions
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
_comp_options+=(globdots)


