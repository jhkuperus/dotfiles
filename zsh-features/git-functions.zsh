GIT_COMMITS_AHEAD_PREFIX="⬆️"
GIT_COMMITS_BEHIND_PREFIX="⬇️"

GIT_REMOTE_SET="✅"
GIT_REMOTE_NOT_SET="⚠️"

function git_current_branch() {
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return # We're not in a GIT repo
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function git_commits_ahead() {
  if $(git rev-parse --git-dir &> /dev/null); then
    # We're in a GIT repo
    local commits=$(git rev-list --count @{upstream}..HEAD)
    if [[ $commits != 0 ]]; then
      echo "$GIT_COMMITS_AHEAD_PREFIX$commits"
    fi
  fi
}

function git_commits_behind() {
  if $(git rev-parse --git-dir &> /dev/null); then
    # We're in a GIT repo
    local commits=$(git rev-list --count HEAD..@{upstream})
    if [[ $commits != 0 ]]; then
      echo "$GIT_COMMITS_BEHIND_PREFIX$commits"
    fi
  fi
}

function git_prompt_remote() {
  if [[ -n "$(git show-ref origin/$(git_current_branch) 2> /dev/null)" ]]; then
    echo $GIT_REMOTE_SET
  else
    echo $GIT_REMOTE_NOT_SET
  fi
}
