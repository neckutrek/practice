#!/bin/bash

# lessons learned:
#  - return multiple values from function: printf "(%s %s ...)" val1 val2 ... ; (array initialization)
#  - receive string with spaces in it inside function: local -a arg=("${!1}")

declare -a FABRIC

function xy2idx { 
  echo $(( $1 + $2 * 1000 )) 
}

function idx2xy {
  printf "( %s %s )" \
    $(( $1 % 1000 )) \
    $(( $1 / 1000 ))
}

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
# output: 
# modifies: array FABRIC

function claim_fabric {
  echo "d: ${FABRIC[@]}" >&2
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

  if [[ "$bx1" < "$ax2" && "$bx2" > "$ax1" ]]; then
    if [[ "$bx1" > "$ax1" ]]; then w1=$bx1
    else w1=$ax1; fi
    if [[ "$bx2" < "$ax2" ]]; then w2=$bx2
    else w2=$ax2; fi
  fi

  if [[ "$by1" < "$ay2" && "$by2" > "$ay1" ]]; then
    if [[ "$by1" > "$ay1" ]]; then h1=$by1
    else h1=$ay1; fi
    if [[ "$by2" < "$ay2" ]]; then h2=$by2
    else h2=$ay2; fi
  fi

  #set -x
  if [[ "$w1" != 0 && "$w2" != 0 && \
        "$h1" != 0 && "$h2" != 0 ]]; then
    for (( i=w1; i<w2; i++ )); do
      for (( j=h1; j<h2; j++ )); do
        local idx=$(xy2idx $i $j)
        set -x
        if [[ ! "${FABRIC[@]}" =~ "${idx}" ]]; then
          FABRIC+=("$idx")
        else
          echo "not: ${FABRIC[@]}" >&2
          echo "$i $j $idx" >&2
        fi
        set +x
      done
    done
  fi
  #set +x

  echo "a: ${FABRIC[@]}" >&2
}

# input:  set of all claims as array of strings
# output: square inches of overlapping fabric
function total_overlap_fabric {
  local -a args=("${!1}")
  local sqi=0
  
  for (( i=0; i<"${#args[@]}"-1; i++ )); do
    for (( j=i+1; j<"${#args[@]}"; j++ )); do
      echo "claim: $i $j" >&2
      echo "b: ${FABRIC[@]}" >&2
      $(claim_fabric args["$i"] args["$j"])
      echo "c: ${FABRIC[@]}" >&2
    done
  done
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

