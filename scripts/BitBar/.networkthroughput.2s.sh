#!/bin/bash

export PATH="/usr/local/bin:${PATH}"
export DIR="$HOME/source-code/scripts/BitBar"

displayNotification() {
  title=$1
  content=$2
  osascript -e "display notification \"$content\" with title \"$title\""
}

usageFormat() {
  # kb=$(bc -l <<< "scale=1; $1");
  kb=$1
  local str
  local rate_unit="KB/s"
  if (($(echo "$kb> 1024" | bc -l))); then
    # local mb  = $((kb / 1024,0))
    str=$(bc -l <<<"scale=1; $kb/1024.0")
    rate_unit="MB/s"
  else
    str=$(bc -l <<<"scale=2; ${kb}")
  fi

  str=$(bc -l <<<"scale=2; if(($str<1) && ($str>0)){\"0\"}; $str")
  str="$str $rate_unit"

  echo "$str"
}

updateStat() {
  local sel=$1
  local currBytes=$2
  local totalBytes=$3
  local percent=$(bc -l <<<"scale=1; $currBytes / $totalBytes * 100.0")
  percent="$percent %"
}

usage() {
  local bytes=$(($1))
  # local kb=$((bytes/1024.0))

  # local kb=$(bc -l <<< "scale=1; val=$bytes/1024.0; if(val<1){\"0\"}; val")
  local kb=$(bc -l <<<"scale=1; $bytes/1024.0")

  echo $(usageFormat $kb)
}

export OUTPUT=~/source-code/scripts/BitBar/network-throughput/network.out

function getBytes() {
  netstat -w1 >$OUTPUT &
  sleep 1.5
  kill -9 $!
}

BYTES=$(getBytes >/dev/null)
BYTES=$(cat $OUTPUT | grep '[0-9].*')
BYTES=$(echo $BYTES | awk '{print $3 "^" $6}')
# echo $BYTES;
declare -a array=($(echo $BYTES | tr "^" " "))

downBytes=${array[0]}
upBytes=${array[1]}

valDown=$(usage $downBytes)
valUp=$(usage $upBytes)

echo "$(usage $downBytes)▼▲$valUp"
# echo "$(usage $downBytes)▼";
