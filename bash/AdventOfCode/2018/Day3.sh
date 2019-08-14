#!/bin/bash

# lessons learned:
#  - return multiple values from function: printf "(%s %s ...)" val1 val2 ... ; (array initialization)
#  - receive string with spaces in it inside function: local -a arg=("${!1}")

export LC_ALL=C # disables unicode support, to improve performance

declare -A "FABRIC" # associative array is faster in Bash than indexed array (when overwriting)

# input:  2 claims as strings
# output: 
# modifies: array FABRIC
function claim_fabric {
  local -a c1=$1
  local -a c2=$2

  #echo "c1: ${#c1[@]}   ${c1[@]}" >&2
  #echo "c2: ${#c2[@]}   ${c2[@]}" >&2
  #echo "FABRIC: ${FABRIC[@]}" >&2

  local w1=$(( "${c1[0]}" > "${c2[0]}" ? "${c1[0]}" : "${c2[0]}" ))
  local w2=$(( "${c1[2]}" < "${c2[2]}" ? "${c1[2]}" : "${c2[2]}" ))
  local h1=$(( "${c1[1]}" > "${c2[1]}" ? "${c1[1]}" : "${c2[1]}" ))
  local h2=$(( "${c1[3]}" < "${c2[3]}" ? "${c1[3]}" : "${c2[3]}" ))
  
  if [[ "$w1" < "$w2" && "$h1" < "$h2" ]]; then
    local i j
    #echo "$w1 $h1 $w2 $h2" >&2
    for (( i=w1; i<w2; i++ )); do
      for (( j=h1; j<h2; j++ )); do
        local idx="x${i}x${j}"
        [[ -v FABRIC["$idx"] ]] || {
          FABRIC["$idx"]+="x"
          #echo "$idx" >&2
        }
      done
    done 
  fi
  
  #echo "FABRIC: ${FABRIC[@]}" >&2

  #echo "=====" >&2
}

# input:  set of all claims as array of strings
# output: square inches of overlapping fabric
function total_overlap_fabric {
  local -a args=("${!1}")

  local i j
  for (( i=0; i<"${#args[@]}"-1; i++ )); do
    printf "$i " >&2
    for (( j=i+1; j<"${#args[@]}"; j++ )); do
      
      claim_fabric "${args[$i]}" "${args[$j]}"
    done
  done

  echo "${#FABRIC[@]}"
}

# input:  "#<id> @ <left>,<top>: <width>x<height>"
# output: ( <x1> <y1> <x2> <y2> )
function extract_claim {
  local -a data=$(printf "(%s %s %s %s)" \
    $(sed -r 's/.* ([0-9]+),.*/\1/g' <<< $1) \
    $(sed -r 's/.*,([0-9]+):.*/\1/g' <<< $1) \
    $(sed -r 's/.* ([0-9]+)x.*/\1/g' <<< $1) \
    $(sed -r 's/.*x([0-9]+)$/\1/g' <<< $1))

  printf "(%s %s %s %s)" \
    "${data[0]}" "${data[1]}" \
    $((data[0]+data[2])) $((data[1]+data[3]))
}

function main {
  echo "- - - START - - -"
  echo `date "+%Y-%m-%d %H:%M:%S"`
  echo 

  echo "Preprocessing data..."
  declare -a claims
  IFS="\n"
  while read; do
    claims+=($(extract_claim $REPLY))
  done < <(echo $(<./input.txt))
  unset IFS
  echo
  echo "Preprocessing done!"

  printf "Total overlapping fabric: %s square inches\n" $(total_overlap_fabric claims[@])

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
