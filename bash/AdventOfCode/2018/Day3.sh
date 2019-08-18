#!/bin/bash

# lessons learned:
#  - return multiple values from function: printf "(%s %s ...)" val1 val2 ... ; (array initialization)
#  - receive string with spaces in it inside function: local -a arg=("${!1}")

export LC_ALL=C # disables unicode support, to improve performance

function solve {
  local -a args=("${!1}")
  local -A m

  for (( i=0; i<"${#args[@]}"; i++ )); do
    local -a c="${args[$i]}"
    for (( x="${c[0]}"; x<"${c[2]}"; x++ )); do
      for (( y="${c[1]}"; y<"${c[3]}"; y++ )); do
        (( m["x${x}y${y}"]++ ))
      done
    done
  done

  local -i sum=0
  for k in "${!m[@]}"; do
    if [[ "${m[$k]}" -ge 2 ]]; then
      (( sum += 1 ))
    fi
  done

  printf "%s" $sum
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

  printf "Preprocessing data...\n"
  declare -a claims
  IFS="\n"
  while read; do
    claims+=($(extract_claim $REPLY))
  done < <(echo $(<./input.txt))
  unset IFS
  printf "Preprocessing done!\n\n"

  printf "Total overlapping fabric: %s square inches\n" $(solve claims[@])

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
