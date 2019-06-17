
function twmonth() {
        local Y1
        local Y2
        local M1
        local M2

        Y1=$1
        M1=$(printf "%02d" $2)

        if [[ $2 == 12 ]];
        then
                M2=01
                Y2=$(($1+1))
        else
                M2=$(printf "%02d" $(($2+1)))
                Y2=$1
        fi

        local FROM=${Y1}${M1}01T0000
        local TO=${Y2}${M2}01T0000

        shift
        shift

        echo "Showing Time Tracker Month from $FROM til $TO with tags: $*"

        timew month ${FROM} - ${TO} $*
}
