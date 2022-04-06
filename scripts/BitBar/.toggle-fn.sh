#!/usr/bin/env bash

if [[ "$1" == "toggle" ]]; then
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
  exit 0
fi

if [[ "$1" == "run-toggle" ]]; then
  open ${0%/*}/toggle-fn.app
fi
echo "☯| bash=$0 param1=run-toggle terminal=false refresh=true"


