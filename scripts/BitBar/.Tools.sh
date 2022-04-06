#!/usr/bin/env bash

function urlencode() {
  data=${$1:-`pbpaste`}
  1=data
  local LANG=C
  for ((i = 0; i < ${#1}; i++)); do
    if [[ ${1:$i:1} =~ ^[a-zA-Z0-9\.\~\_\-]$ ]]; then
      printf "${1:$i:1}"
    else
      printf '%%%02X' "'${1:$i:1}"
    fi
  done
}

[ $# == 1 ] && {
  $1
  exit 0
}

echo "Tools | size=12 color=green"
echo "---"
echo "Encode | bash='$0' param1=urlencode terminal=false"