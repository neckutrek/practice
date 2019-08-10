#!/bin/bash

# lessons learned:
#  - 

# left top width height
function extract_square_info {
  printf "%s %s %s %s" \
    $(sed -r 's/.* ([0-9]+),.*/\1/g' <<< $1) \
    $(sed -r 's/.*,([0-9]+):.*/\1/g' <<< $1) \
    $(sed -r 's/.* ([0-9]+)x.*/\1/g' <<< $1) \
    $(sed -r 's/.*x([0-9]+)$/\1/g' <<< $1)
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

