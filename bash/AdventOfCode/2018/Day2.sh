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

function get_common_strings {
  local arr=("$@")

  local ndiff=0
  for (( i=0; i<${#arr[@]}-1; i++)); do
    for (( j=i+1; j<${#arr[@]}; j++)); do
      for (( k=0; k<${#arr[i]}; k++)); do
        if [ "${arr[$i]:$k:1}" != "${arr[$j]:$k:1}" ]; then
          ((ndiff++))
          if [ $ndiff > 1 ]; then break; fi
        fi
      done
      if [ $ndiff == 1 ]; then break 2; fi
      unset ndiff
    done
  done
  
  if [ $ndiff == 1 ]; 
  then echo "${arr[$i]} ${arr[$j]}";
  else echo "";
  fi
}

function main {
  echo "- - - START - - -"
  echo `date "+%Y-%m-%d %H:%M:%S"`
  echo

  declare -a strings
  while read; do
    strings+=($REPLY)
  done < <(echo $(<./input2.txt))

  #echo $(get_checksum "${strings[@]}")

  echo $(get_common_strings "${strings[@]}")

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
