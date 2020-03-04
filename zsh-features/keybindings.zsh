
# Function to switch brances in Git repo's
function select_branch() {
  local branch

  zle -M "Select a branch to switch to:\n"

  branch=$(git branch -a --list --format "%(refname:lstrip=2)" | FZF_DEFAULT_OPTS="--height 30% $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" fzf)

  if [[ ! -z "$branch" ]];
  then
    local hasPackageJson=0
    local gitRoot=$(git rev-parse --show-toplevel)
    local currentPackageJsonHash=

    if [[ -f $(git rev-parse --show-toplevel)/package.json ]];
    then
      hasPackageJson=1
      currentPackageJsonHash=$(cat $gitRoot/package.json | jq ".dependencies,.devDependencies" | md5)
    fi
    # Note to future self: the syntax ${variable/<regex>/<replacement>} is just frikkin awesome
    git checkout ${branch/origin\//}

    if [[ $hasPackageJson == 1 ]];
    then
      local newPackageJsonHash=$(cat $gitRoot/package.json | jq ".dependencies,.devDependencies" | md5)

      if [[ $newPackageJsonHash != $currentPackageJsonHash ]];
      then
        local SELECTION

        echo "The package.json has changed between branches, running npm i in 2 seconds unless you cancel it now..."
        sleep 2

        local popdOne=0
        if [[ $(pwd) != $gitRoot ]];
        then
          pushd $gitRoot
          popdOne=1
        fi

        npm i

        if [[ $popdOne == 1 ]];
        then
          popd
        fi
      fi
    fi
  fi

  echo "\n\n"
  zle reset-prompt
}
 
zle -N select_branch

bindkey "^x^x^b" select_branch

