#!/bin/bash

dedup() {
  arr=$(node -e "arr=\`$(pbpaste)\`.replace(/^\s+|\s+$/g, '').split(/\s+/); console.log(JSON.stringify([...new Set (arr)]));")
  echo $arr | pbcopy
  sleep .1
#  bash ${0%/*}/.notify.sh displayNotification dedup $arr
  exit
}

"$@"

echo "Dedup | bash=/bin/bash param1=$0 param2=dedup size=12 terminal=false refresh=true"
