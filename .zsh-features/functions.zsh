
# Buffer and Prompt functions
#

function inject_text_into_buffer() {
  local TMP=$RBUFFER
  BUFFER="$LBUFFER$1"
  CURSOR="$#BUFFER"
  BUFFER="$BUFFER$TMP"
}

function inject_current_branch() {
  inject_text_into_buffer $(current_branch)
}

function inject_current_ticket_number() {
  inject_text_into_buffer $(currnt_branch | sed -e 's/[-_].*//' -e 's/^[^/]*\///')
}

function switch_branch() {
  echo "\nSwitching branches..."
  git checkout -
  echo ""
  zle reset-prompt
}

function select_branch() {
  local branch

  zle -M "Select a branch to switch to:\n"

  branch=$(git branch -a -0-list --format "(%(refname:lstrip=2)" | FZF_DEFAULT_OPTS="--height 30% $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" fzf)

  if [[ ! -z "$branch" ]];
  then
    # Note to future self: the syntac ${variable/<regex>/<replacement>} is just frikkin awesome
    git checkout ${branch/origin\//}
  fi

  echo "\n\n"
  zle reset-prompt
}

zle -N inject_current_branch
zle -N inject_current_ticket_number
zle -N switch_branch
zle -N select_branch

bindkey "^x^b" inject_current_branch
bindkey "^x^n" inject_current_ticket_number
bindkey "^x^a" switch_branch

bindkey "^x^x^b" select_branch
