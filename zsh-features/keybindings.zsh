
# Function to switch brances in Git repo's
#
# This allows me to switch to branches using ^x^x^b in any Git repository. It
# uses fzf to allow fuzzy searching through branch names. If a repository contains
# a package.json, it will detect differences between branches and run npm i.
# The numbers in this file correspond to the outline of what is happening,
# described in the blogpost at: https://medium.com/@jhkuperus/automatically-running-npm-install-when-switching-branches-432af36c9d2e
function select_branch() {
  local branch

  zle -M "Select a branch to switch to:\n"

  # 1. Here we list all available git branches and feed them to fzf
  # In fzf you can type and fuzzy-search for the branch you want
  # Once a branch is selected, it is returned and stored in branch
  branch=$(git branch -a --list --format "%(refname:lstrip=2)" | \
    FZF_DEFAULT_OPTS="--height 30% $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" fzf)

  # Continue only if a branch was selected
  if [[ ! -z "$branch" ]];
  then
    local hasPackageJson=0
    local gitRoot=$(git rev-parse --show-toplevel)
    local currentPackageJsonHash=

    # 2. If package.json exists on the top of the repository...
    if [[ -f $gitRoot/package.json ]];
    then
      hasPackageJson=1
      # 3. Calculate the hash of relevant parts of package.json
      currentPackageJsonHash=$(cat $gitRoot/package.json | \
        jq ".dependencies,.devDependencies" | \
        md5)
    fi
    # Note to future self: the syntax ${variable/<regex>/<replacement>} is just frikkin awesome
    # 4. Actually switch to the selected branch
    git checkout ${branch/origin\//}

    if [[ $hasPackageJson == 1 ]];
    then
      # 5. Calculate has of package.json again
      local newPackageJsonHash=$(cat $gitRoot/package.json | jq ".dependencies,.devDependencies" | md5)

      # 6. If hashes differ, run npm install
      if [[ $newPackageJsonHash != $currentPackageJsonHash ]];
      then
        echo "The package.json has changed between branches," \
         " running npm i in 2 seconds unless you cancel it now..."
        sleep 2

        # 7. Make sure to remember the path if it's not $gitRoot
        local usePopd=0
        if [[ $(pwd) != $gitRoot ]];
        then
          pushd $gitRoot
          usePopd=1
        fi

        npm i

        # 7b. Use popd to restore the previous path
        if [[ $usePopd == 1 ]];
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

