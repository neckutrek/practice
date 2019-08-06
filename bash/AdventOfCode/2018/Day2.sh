#!/bin/bash

# lessons learned:
#  - size of array: ${#array[@]}
#  - print from within function: printf "%s\n" $msg >&2

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

declare -A CHARS
count_chars CHARS "abbcccdddd"
declare -p CHARS

echo "${CHARS[@]}"

#declare -a STRINGS
#while read; do
#  STRINGS+=($REPLY)
#done < <(echo $(<./input.txt))



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
