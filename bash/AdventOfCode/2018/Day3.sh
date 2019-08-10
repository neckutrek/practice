#!/bin/bash

# lessons learned:
#  - return multiple values from function: printf "(%s %s ...)" val1 val2 ... ; (array initialization)
#  - receive string with spaces in it inside function: local -a arg=("${!1}")

# input:  "#<id> @ <left>,<top>: <width>x<height>"
# output: ( <left> <top> <width> <height> )
function extract_square_info {
  local -a arg=("${!1}")
  printf "(%s %s %s %s)" \
    $(sed -r 's/.* ([0-9]+),.*/\1/g' <<< $arg) \
    $(sed -r 's/.*,([0-9]+):.*/\1/g' <<< $arg) \
    $(sed -r 's/.* ([0-9]+)x.*/\1/g' <<< $arg) \
    $(sed -r 's/.*x([0-9]+)$/\1/g' <<< $arg)
}
#'''

# input:  2 claims as strings
# output: square inches of overlapping fabric
function calc_overlap_fabric {
  local -a arg1=("${!1}")
  local -a arg2=("${!2}")

  local -a claim1=$(extract_square_info arg1)
  local -a claim2=$(extract_square_info arg2)

  local ax1="${claim1[0]}"
  local ax2=$((claim1[0]+claim1[2]))
  local ay1="${claim1[1]}"
  local ay2=$((claim1[1]+claim1[3]))

  local bx1="${claim2[0]}"
  local bx2=$((claim2[0]+claim2[2]))
  local by1="${claim2[1]}"
  local by2=$((claim2[1]+claim2[3]))
  
  local w1=0
  local w2=0
  local h1=0
  local h2=0

  set -x
  if [[ "$bx1" < "$ax2" && "$bx2" > "$ax1" ]]; then
    if [[ "$bx1" > "$ax1" ]]; then w1=$bx1
    else w1=$ax1; fi
    if [[ "$bx2" < "$ax2" ]]; then w2=$bx2
    else w2=$ax2; fi
  fi
  set +x

  if [[ "$by1" < "$ay2" && "$by2" > "$ay1" ]]; then
    if [[ "$by1" > "$ay1" ]]; then h1=$by1
    else h1=$ay1; fi
    if [[ "$by2" < "$ay2" ]]; then h2=$by2
    else h2=$ay2; fi
  fi

  echo "claim1= ${claim1[@]}" >&2
  echo "claim2= ${claim2[@]}" >&2
  echo "$w1 $w2 $h1 $h2" >&2
  echo "" >&2

  echo $(( (w2-w1)*(h2-h1) ))
}

# input:  set of all claims as array of strings
# output: square inches of overlapping fabric
function total_overlap_fabric {
  local -a args=("${!1}")
  local sqi=0
  for (( i=0; i<"${#args[@]}"-1; i++ )); do
    for (( j=i+1; j<"${#args[@]}"; j++ )); do
      local sqii=$(calc_overlap_fabric args["$i"] args["$j"])
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

  printf "Total overlapping fabric: %s square inches\n" $( total_overlap_fabric strings[@] )

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"

