# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


function load {
  [[ -f "$1" ]] && source "$1"
}

# Load configuration
h=$HOME/.config/zsh
load $h/settings.zsh
load $h/history.zsh
load $h/dependencies.zsh
load $h/functions.zsh
load $h/environment.zsh
load $h/detect-os.zsh
load $h/keybindings.zsh

# Load all files with aliases
for af in "$h"/aliases/*; do
  if [[ -f "$af" ]]; then
    load $af
  fi
done


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
