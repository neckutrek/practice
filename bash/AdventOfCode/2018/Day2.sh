#!/bin/bash

# lessons learned:
#  - size of array: ${#array[@]}
#  - print from within function: printf "%s\n" $msg >&2
#  - expanding an array only gives the first argument, use "${array[@]}" instead

function get_checksum {
  local arr=("$@")

  local twos=0
  local threes=0
  for str in "${arr[@]}"; do
    
    local -A n_chars
    for (( i=0; i<"${#str}"; i++)); do
      char="${str:$i:1}"
      ((n_chars[$char]++))
    done

    for i in "${!n_chars[@]}"; do
      if [ "${n_chars[$i]}" == 2 ]; then
        ((twos++))
        break
      fi
    done

    for j in "${!n_chars[@]}"; do
      if [ "${n_chars[$j]}" == 3 ]; then
        ((threes++))
        break
      fi
    done

    unset n_chars
  done

  echo "$((twos*threes))"
}

function main {
  echo "- - - START - - -"
  echo `date "+%Y-%m-%d %H:%M:%S"`
  echo

  declare -a strings
  while read; do
    strings+=($REPLY)
  done < <(echo $(<./input.txt))

  echo $(get_checksum "${strings[@]}")

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
