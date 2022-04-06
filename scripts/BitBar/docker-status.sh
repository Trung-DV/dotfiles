#!/usr/bin/env bash
#
# <bitbar.title>Docker Status</bitbar.title>
# <bitbar.version>v1.1</bitbar.version>
# <bitbar.author>Manoj Mahalingam</bitbar.author>
# <bitbar.author.github>manojlds</bitbar.author.github>
# <bitbar.image>https://cloud.githubusercontent.com/assets/191378/12255368/1e671b32-b919-11e5-8166-6d975396f408.png</bitbar.image>
# <bitbar.desc>Displays the status of docker machines and running containers</bitbar.desc>
# <bitbar.dependencies>shell,docker,docker-machine</bitbar.dependencies>
#
# Docker status plugin
# by Manoj Mahalingam (@manojlds)
#
# Displays the status of docker machines and running containers

export PATH="/usr/local/bin:/usr/bin:$PATH"

#export DOCKER_HOST="18.138.127.103:17616"

displayNotification() {
  title=$1
  content=$2
  osascript -e "display notification \"$content\" with title \"$title\""
}
#displayNotification "$@" "Notify----------"

if [[ "$1" == "displayNotification" ]]; then
  displayNotification "$2" "$3"
fi
if [[ "$1" == "testDisplayNotification" ]]; then
  allArg="$1 $2 $3 $4"
  displayNotification "Test Notify" "$allArg"
fi

function containers() {
  CONTAINERS=$(docker ps -a --format "{{.Names}} ({{.Image}})|{{.ID}}|{{.Status}}")
  if [ -z "$CONTAINERS" ]; then
    echo "No running containers"
  else
    LAST_CONTAINER=$(echo "$CONTAINERS" | tail -n1)
    echo "${CONTAINERS}" | while read -r CONTAINER; do
      #      echo "$CONTAINER"
      IFS='|' read -r CONTAINER_NAME CONTAINER_ID CONTAINER_STATE <<<"$CONTAINER"
      SYM="├ 💻 "
      if [ "$CONTAINER" = "$LAST_CONTAINER" ]; then SYM="└ 💻 "; fi
      case "$CONTAINER_STATE" in
      *Up*)
        echo "$SYM $CONTAINER_NAME | color=green bash=$(command -v docker) param1=stop param2=$CONTAINER_ID terminal=false refresh=true"
        ;;
      *Exited*)
        echo "$SYM $CONTAINER_NAME | color=red bash=$(command -v docker) param1=start param2=$CONTAINER_ID terminal=false refresh=true"
        ;;
      *)
        echo "$SYM $CONTAINER_NAME $CONTAINER_STATE | color=#3FFFFF bash=$(command -v docker) param1=start param2=$CONTAINER_ID terminal=false refresh=true"
        ;;
      esac
      echo "--Enter | bash=$(dirname "$0")/.iterm-docker-exec.js param1=$CONTAINER_ID terminal=false refresh=true"
      echo "--Remove | bash=$(command -v docker) param1=container param2=rm param3=$CONTAINER_ID terminal=false refresh=true"
      echo "--Reset | bash=$(command -v docker) param1=container param2=restart param3=$CONTAINER_ID terminal=false refresh=true"
    done
  fi
}

function main() {
  DOCKER_MACHINES="$(docker-machine ls -q)"
  DLITE="$(command -v dlite)"
  DOCKER_NATIVE="$(command -v docker)"

  if test -z "$DOCKER_MACHINES" && test -z "$DLITE" && test -z "$DOCKER_NATIVE"; then
    echo "No docker machine, dlite or docker native found"
    exit 0
  fi

  if [ -n "$DOCKER_NATIVE" ]; then
    MACHINE="$(docker -v)"
    CONTAINERS="$(docker ps -a --format "{{.Names}} ({{.Image}})|{{.ID}}|{{.Status}}")"
    if [ -n "$CONTAINERS" ]; then
      echo "🔵  $MACHINE | bash=$(command -v docker) param1=stop terminal=false refresh=true"
      containers
    fi
    return 0
  fi

  if [ -n "$DLITE" ]; then
    MACHINE="$(dlite ip)"
    CONTAINERS="$(docker ps -a --format "{{.Names}} ({{.Image}})|{{.ID}}|{{.Status}}")"
    if [ -z "$CONTAINERS" ]; then
      echo "🔴  $MACHINE | bash=$(command -v dlite) param1=start terminal=false refresh=true"
    else
      echo "🔵  $MACHINE | bash=$(command -v dlite) param1=stop terminal=false refresh=true"
      containers
    fi
    exit 0
  fi

  if [ -n "$DOCKER_MACHINES" ]; then
    echo "${DOCKER_MACHINES}" | while read -r machine; do
      STATUS=$(docker-machine status "$machine")
      if [ "$STATUS" = "Running" ]; then
        echo "🔵  $machine | bash=$(command -v docker-machine) param1=stop param2=$machine terminal=false refresh=true"
        ENV=$(docker-machine env --shell sh "$machine")
        eval "$ENV"
        containers
      else
        echo "🔴  $machine | bash=$(command -v docker-machine) param1=start param2=$machine terminal=false refresh=true"
      fi
      echo "---"
    done
  fi

  if [ -n "$CONTAINERS" ]; then
    echo "Docker VM Containers"
    containers
  fi
}

echo "⚓️ | dropdown=true"
echo "---"

#containers
main
#open "bitbar://refreshPlugin?name=docker-status.1m.sh"

exit 0
