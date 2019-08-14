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

  echo "c1: ${#c1[@]}   ${c1[@]}" >&2
  echo "c2: ${#c2[@]}   ${c2[@]}" >&2
  echo "FABRIC: ${FABRIC[@]}" >&2

  local w1=0
  local w2=0
  local h1=0
  local h2=0

  if [[ "${c2[0]}" < "${c1[2]}" && "${c2[2]}" > "${c1[0]}" ]]; then
    if [[ "${c2[0]}" > "${c1[0]}" ]]; then w1="${c2[0]}"
    else w1="${c1[0]}"; fi
    if [[ "${c2[2]}" < "${c1[2]}" ]]; then w2="${c2[2]}"
    else w2="${c1[2]}"; fi
  fi

  if [[ "${c2[1]}" < "${c1[3]}" && "${c2[3]}" > "${c1[1]}" ]]; then
    if [[ "$by1" > "${c1[1]}" ]]; then h1="${c2[1]}"
    else h1="${c1[1]}"; fi
    if [[ "${c2[3]}" < "${c1[3]}" ]]; then h2="${c2[3]}"
    else h2="${c1[3]}"; fi
  fi

  if [[ "$w1" != 0 && "$w2" != 0 && \
        "$h1" != 0 && "$h2" != 0 ]]; then
    local i j
    for (( i=w1; i<w2; i++ )); do
      for (( j=h1; j<h2; j++ )); do
        local idx="x${i}x${j}"
        [[ -v FABRIC["$idx"] ]] || FABRIC["$idx"]+="x"
      done
    done 
  fi
  
  echo "FABRIC: ${FABRIC[@]}" >&2

  echo "=====" >&2
}

# input:  set of all claims as array of strings
# output: square inches of overlapping fabric
function total_overlap_fabric {
  local -a args=("${!1}")

  local i j
  for (( i=0; i<"${#args[@]}"-1; i++ )); do
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

  declare -a claims
  IFS="\n"
  while read; do
    claims+=($(extract_claim $REPLY))
  done < <(echo $(<./input2.txt))
  unset IFS
  echo

  total_overlap_fabric claims[@]
  
  #printf "Total overlapping fabric: %s square inches\n" $(total_overlap_fabric strings[@])

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
