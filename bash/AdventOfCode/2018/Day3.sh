#!/bin/bash

# lessons learned:
#  - return multiple values from function: printf "(%s %s ...)" val1 val2 ... ; (array initialization)

# input:  "#<id> @ <left>,<top>: <width>x<height>"
# output: ( <left> <top> <width> <height> )
function extract_square_info {
  printf "(%s %s %s %s)" \
    $(sed -r 's/.* ([0-9]+),.*/\1/g' <<< $1) \
    $(sed -r 's/.*,([0-9]+):.*/\1/g' <<< $1) \
    $(sed -r 's/.* ([0-9]+)x.*/\1/g' <<< $1) \
    $(sed -r 's/.*x([0-9]+)$/\1/g' <<< $1)
}
#'''

# input:  2 claims as strings
# output: square inches of overlapping fabric
function calc_overlap_fabric {
  local -a claim1=$(extract_square_info $1)
  local -a claim2=$(extract_square_info $2)
  
}

# input:  set of all claims as array of strings
# output: square inches of overlapping fabric
function total_overlap_fabric {
  local args=("$@")
  local sqi=0
  for (( i=0; i<"${#args[@]}"-1; i++ )); do
    for (( j=i+1; j<"${#args[@]}"; j++ )); do
      local sqii=$(calc_overlap_fabric "${args[$i]}" "${args[$j]}")
      ((sqi+=sqii))
    done
  done
  echo "$sqi"
}

function main {
  echo "- - - START - - -"
  echo `date "+%Y-%m-%d %H:%M:%S"`
  echo

  declare -a strings
  IFS="\n"
  while read; do
    strings+=($REPLY)
  done < <(echo $(<./input2.txt))
  unset IFS

  printf "Total overlapping fabric: %s square inches\n" $(total_overlap_fabric "${strings[@]}")

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"

