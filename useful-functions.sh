#!/bin/bash

#https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

function pwdx {
  lsof -a -p $1 -d cwd -n #| tail -1 | awk '{print $NF}'
}

weather() {
  local CITY=${1:-Ho Chi Minh}
  wttr=`curl -s wttr.in/$CITY`
  echo $wttr | head -n 37
}


# cd to folder
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# show all hidden folder to 'cd'
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Search in history
fh() {
  eval $(history | fzf +s | sed 's/ *[0-9]* *//')
}

# Kill a process
fk() {
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

#K8s autocomplete
function kubectl() {

    # if [ -f /usr/local/bin/kubectl.docker ]; then
    #   rm /usr/local/bin/kubectl.docker
    # fi
  
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
        # source <(kubectl completion zsh)
    fi

    command kubectl "$@"
}

function iterm2_print_user_vars() {
  iterm2_set_user_var vpn_badge `[[ $(ifconfig | grep 10.79.11.116 -c) != "0" ]] && echo -n "⚡️"`
}

i2-badge() {
  printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" | base64)
}

i2-title() {
  DISABLE_AUTO_TITLE=true
  if [ ! -z $1 ]; then
    echo -ne "\033]0;"$1"\007"
  fi
}; 

kraken() {
  [[ -z $1 ]] && repo=$(pwd) || repo=$(pwd)/$1
  open -na 'GitKraken' --args -p $repo
}

iterm() {
  [[ -z $1 ]] && target=$(pwd) || target=$1
  open -a 'iTerm' $target
}

#ssh -vt localhost "bash --rcfile ~/.iterm2_shell_integration.bash -ci 'bash'"

# printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "\(user.myBadge)" | base64)
# setbadge() { printf "\e]1337;SetUserVar=myBadge=%s\a" $(echo $1 | base64); }
