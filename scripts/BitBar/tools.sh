#!/usr/bin/env bash

displayNotification() {
  title=$1
  content=$2
  osascript -e "display notification \"$content\" with title \"$title\""
}

typing() {
  sh -c "osascript <<-EndOfScript
    tell application \"System Events\" to keystroke \"`pbpaste`\"
  EndOfScript"
}

run-toggle() {
  sh -c "osascript <<-EndOfScript
      tell application \"System Events\" to set isRunning to exists (processes where name is \"System Preferences\")
      tell application id \"com.apple.systempreferences\"
      	reveal anchor \"keyboardTab\" of pane id \"com.apple.preference.keyboard\"
      end tell

      tell application \"System Events\" to tell process \"System Preferences\"

      	if not isRunning then delay 0.1


      	set currentState to value of attribute \"AXValue\" of pop up button 2 of tab group 1 of window \"Keyboard\"

      	if currentState is \"App Controls\" then
      		set newState to \"F1, F2, etc. Keys\"
      	else if currentState is \"F1, F2, etc. Keys\" then
      		set newState to \"App Controls\"
      	end if

      	tell pop up button 2 of tab group 1 of window \"Keyboard\"
      		perform action \"AXShowMenu\"
      		tell menu 1
      			click menu item newState
      		end tell
      	end tell
      end tell
      (*quit application \"System Preferences\"*)
  EndOfScript"
}


[ $# == 1 ] && {
  $1
  exit 0
}


curDir=${0%/*}
echo "Tools | size=12 color=orange"
echo "---"
echo "⌨️ Typing | bash=$0 param1=typing size=12 color=green terminal=false refresh=false"
bash $curDir/.ssh-tunnel.sh
bash $curDir/.ts-vpn.sh
echo "🎛 Toggle-Fn | bash=$0 param1=run-toggle size=12 color=purple terminal=false refresh=false"
bash $curDir/.connect-s4m-vpn.1s.sh
echo "---"
bash $curDir/.TypeUtils.sh
echo "---"
#
#echo "JSON | size=12 color=cadetblue"
#echo "--Validate | bash='${0%/*}/.TypeUtils.sh' param1=validateJson terminal=false"
#echo "--Format | bash='${0%/*}/.TypeUtils.sh' param1=formatJson terminal=false"
#echo "--Compact | bash='${0%/*}/.TypeUtils.sh' param1=compactJson terminal=false"
#echo "--To Yaml | bash='${0%/*}/.TypeUtils.sh' param1=jsonToYaml terminal=false"
#echo "YAML | size=12 color=green"
#echo "--Validate | bash='${0%/*}/.TypeUtils.sh' param1=validateYaml terminal=false"
#echo "--Sort | bash='${0%/*}/.TypeUtils.sh' param1=sortYaml terminal=false"
#echo "--To Json | bash='${0%/*}/.TypeUtils.sh' param1=yamlToJson terminal=false"
#echo "--To Prop | bash='${0%/*}/.TypeUtils.sh' param1=yamlToProp terminal=false"

#echo "---"
bash ${0%/*}/.strings.sh
bash ${0%/*}/.dedup.sh
