#!/bin/bash

# lessons learned:
#  - size of array: ${#array[@]}
#  - print from within function: printf "%s\n" $msg >&2
#  - expanding an array only gives the first argument, use "${array[@]}" instead


echo "- - - START - - -"
echo `date "+%Y-%m-%d %H:%M:%S"`
echo

function compare_strings {
  local n_equal=0
  for (( i=0; i < ${#1} ; i++)); do
    if [ ${1:$i:1} == ${2:$i:1} ]; then
      ((n_equal+=1))
    fi
  done
  echo $n_equal
}

function count_chars {
  local -n n_chars=$1
  for (( i=0; i<${#2}; i++)); do
    char=${2:$i:1}
    ((n_chars[$char]++))
  done
}

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
      if [ "${n_chars[i]}" == 2 ]; then
        ((twos++))
        break
      fi
    done

    for i in "${!n_chars[@]}"; do
      if [ "${n_chars[i]}" == 3 ]; then
        ((threes++))
        break
      fi
    done

    echo "$str" >&2
    echo "${!n_chars[@]}" >&2
    echo "${n_chars[@]}" >&2
    echo "" >&2

    unset n_chars

  done

  echo "$twos" >&2
  echo "$threes" >&2

  echo "$((twos*threes))"
}

#declare -A CHARS
#count_chars CHARS "abbcccdddd"
#declare -p CHARS

declare -a strings
while read; do
  strings+=($REPLY)
done < <(echo $(<./input.txt))

echo $(get_checksum "${strings[@]}")


#n_twos=0
#n_threes=0
#len=1 #${#STRINGS[@]}
#for (( i=1; i<len; i++ )); do
  
  #((p=i-1))
  #n=$(compare_strings "${STRINGS[p]}" "${STRINGS[i]}")
  #echo $n
  #if [ n==2 ]; then
  #  ((n_twos+=1))
  #  elif [ n==3]; then
  #  ((n_threes+=1))
  #fi
#done
#printf "%s\n" $n_twos
#printf "%s\n" $n_threes
#printf "checksum: %s\n" $((n_twos*n_threes))

echo
echo "- - - FINAL - - -"
