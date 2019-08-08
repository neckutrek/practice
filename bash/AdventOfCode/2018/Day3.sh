#!/bin/bash

# lessons learned:
#  - 

function main {
  echo "hello world!"
}

[[ $_ != $0 ]] && main "$@"
