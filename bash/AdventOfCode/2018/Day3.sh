#!/bin/bash

# lessons learned:
#  - 

function extract_square_info {
  set -x
  #local left=$(echo "$1" | sed "s/([0-9][0-9]*)\,//p")
  #local str='#1 @ 1,3: 4x4'
  #sed "s/([0-9][0-9]*)\,/hello/p" <<< $str >&2
  #local str2='hello 12 @ 34,56,78,90 x'
  sed -r 's/.*([0-9][0-9]*).*/hej/g' <<< $str >&2
  #echo 'abcabcabc' | sed 's/\(ab\)c/\1/g'
  #echo "left = $str" >&2
  set +x
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

  echo $(extract_square_info "${strings[0]}")

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
