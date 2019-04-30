
# AnyBar Integration
#
function newSingleShotAnyBar() {
  local LABEL
  local COLOR

  COLOR=$1
  LABEL=$2

  if [[ -z "$LABEL" ]];
  then
	  LABEL=Nothing special...
  fi
	
  ANYBAR_LABEL="$LABEL" ANYBAR_PORT=none ANYBAR_INITIAL=$COLOR open -na AnyBar
}

