setopt prompt_subst

export SESSION_DANGER_CAPABLE=1
export SESSION_CONTEXT_CAPABLE=1
MODE_INDICATOR=""

function prompt_injection() {
  local INJECTIONS=""
  [[ -e ~/.setEnv/prompt ]] && INJECTIONS+=`cat ~/.setEnv/prompt`
  [[ ! -z $SESSION_TYPE ]] && INJECTIONS+=$SESSION_TYPE
  [[ ! -z $SESSION_DANGER ]] && INJECTIONS+=$SESSION_DANGER
  echo $INJECTIONS
}

function ret_status() {
  local RET_STATUS=""
  [[ $1 -ne 0 ]] && RET_STATUS="⨯"
  echo $RET_STATUS
}

function root_and_jobs() {
  local SYMS=""
  [[ $UID -eq 0 ]] && SYMS+="⚡️ "
  [[ $(jobs -l | wc -l) -gt 0 ]] && SYMS="λ"
  echo $SYMS
}

function working_directory() {
  echo "%~"
}

function is_inside_git() {
  [[ -n "$GIT_STATUS_FULL" ]]
}

function is_git_dirty() {
  # This regex looks like a smiley but it means there must be no space on the second char of the line
  echo $GIT_STATUS | grep "^.[^ ]" > /dev/null 2>&1
  [[ "$?" -eq 0 ]] && echo $1 || echo $2
}

function git_branch() {
  local BRANCH=$(git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/")
  [[ -n $BRANCH ]] && echo $BRANCH || echo "?"
}

function git_local() {
  local INFO=""

  # Stage changes
  echo $GIT_STATUS | grep "^D" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="D"
  echo $GIT_STATUS | grep "^A" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="A"
  echo $GIT_STATUS | grep "^M" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="M"
  echo $GIT_STATUS | grep "^R" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="R"

  # Assumed flag
  local GIT_ASSUMED=$(git ls-files -v | grep ^h 2> /dev/null)
  [[ -n "$GIT_ASSUMED" ]] && INFO+="(ASSUMED)"

  echo $INFO
}

function git_remote() {
  local INFO=""

  # Ahead, behind
  echo $GIT_STATUS_FULL | grep "ahead" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="↑$(echo "$GIT_STATUS_FULL" | sed 's/.*ahead \([0-9]*\).*/\1/; 1q')"
  echo $GIT_STATUS_FULL | grep "behind" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="↓$(echo "$GIT_STATUS_FULL" | sed 's/.*behind \([0-9]*\).*/\1/; 1q')"

  # Stashes flag
  [[ -e "$(git rev-parse --show-toplevel)/.git/refs/stash" ]] && INFO+="Σ"

  echo $INFO
}

function git_warnings() {
  local WARNINGS=""

  # Diverged
  echo $GIT_STATUS_FULL | grep "ahead" | greph "behind" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && WARNINGS+="Δ"

  # Merging
  echo $GIT_STATUS_FULL | grep "Unmerged paths" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && WARNINGS+="🔀"

  # Warning for no email
  git config user.email | grep @ > /dev/null 2>&1
  [[ "$?" -ne "0" ]] && WARNINGS+="!!! NO EMAIL SET !!!"

  echo $WARNINGS
}

function build_prompt() {
  # Capturing the exit code must happen first
  local EXIT=$?

  local RAW_SEP="❱"
  local SEPCOLOR=$CYAN
  local SEP="$SEPCOLOR$RAW_SEP"
  local P=""

  P+="$WHITE⎡"

  local INJECTION=$(prompt_injection)
  [[ -n "$INJECTION" ]] && P+="$SEP $INJECTION"

  [[ ! -z $SESSION_CONTEXT ]] && P+="$SEP $YELLOW${SESSION_CONTEXT} "

  P+="$SEP $GREEN$(working_directory)"

  GIT_STATUS_FULL=$(git status -sb 2> /dev/null)
  local GIT_WARNINGS=""
  if is_inside_git
  then
    GIT_STATUS=$(git status --porcelain 2> /dev/null)

    P+=" $SEP $YELLOW$(git_branch)"

    local REMOTE=$(git_remote)
    local LOCAL=$(git_local)
    [[ -n "$REMOTE" ]] && P+=" $SEP $YELLOW$REMOTE"
    [[ -n "$LOCAL" ]] && P+=" $SEP $YELLOW$LOCAL"

    GIT_WARNINGS=$(git_warnings)
  fi

  P+=" $SEP"

  P+="\n%{$(iterm2_prompt_mark)%}"
  P+="$WHITE⎣"

  local SYMS=$(root_and_jobs)
  local RET_STATUS=$(ret_status $EXIT)
  [[ -n "$RET_STATUS$SYMS$GIT_WARNINGS" ]] && P+="$SEP "
  [[ -n "$SYMS" ]] && P+="$YELLOW$SYMS"
  [[ -n "$RET_STATUS" ]] && P+="$RED$RET_STATUS"
  [[ -n "$GIT_WARNINGS" ]] && P+="$RED$GIT_WARNINGS"
  [[ -n "$RET_STATUS$SYMS$GIT_WARNINGS" ]] && P+=" "

  P+="$(is_git_dirty $RED $SEPCOLOR)$RAW_SEP"

  P+="%{$reset_color%} "

  echo $P
}

PROMPT=$'$(build_prompt)'

precmd_functions=($precmd_functions tab_color_default)




