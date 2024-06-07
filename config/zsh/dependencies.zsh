## Linuxbrew
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

## Or Homebrew
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# SDKMan (lazy loaded because it's really slow on zsh; see https://github.com/sdkman/sdkman-cli/issues/977)
export SDKMAN_DIR="$HOME/.sdkman"
sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# FZF
eval "$(fzf --zsh)"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# ZInit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add other plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completions
autoload -Uz compinit
## Use cache unless .zcompdump file is older than a day
if [ -n "$(find ${ZDOTDIR}/.zcompdump -mmin +1440 2> /dev/null)" ]; then
  compinit
else
  compinit -C
fi
zinit cdreplay -q

## Case-insensitive completions, and match within words
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*'
## Colors for completions
[ -f "$(which dircolors)" ] && eval "$(dircolors -b)" # set LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

## Use fzf to pick completion
zstyle ':completion:*' menu no
## Show previews while completing in fzf
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --color=always $realpath'

## Show previews while completing with zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'exa --icons --color=always $realpath'

# Autosuggestions
## Make suggestion more readable
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
