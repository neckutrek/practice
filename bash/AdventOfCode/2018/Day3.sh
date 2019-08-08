#!/bin/bash

# lessons learned:
#  - 

function extract_square_info {
  echo "$1" >&2
}

function main {
  echo "- - - START - - -"
  echo `date "+%Y-%m-%d %H:%M:%S"`
  echo

  declare -a strings
  while read; do
    strings+=($REPLY)
  done < <(echo $(<./input.txt))

  echo $(extract_square_info "${strings[0]}")

  echo
  echo "- - - FINAL - - -"
}

[[ $_ != $0 ]] && main "$@"
