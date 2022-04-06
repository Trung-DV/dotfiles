#!/bin/bash
#https://blog.timac.org/2018/0719-vpnstatus/
VPN="S4m"

if [[ "$1" == "connectVPN" ]]; then
  sh -c "osascript <<-EndOfScript
    set MyVPNName to \"$VPN\"

    tell application \"System Events\"
      tell current location of network preferences
        set myConnection to the service MyVPNName
        if myConnection is not null then
          connect myConnection
        end if
      end tell
    end tell
  EndOfScript"
  exit 0
fi

IS_CONNECTED=$(test -z `scutil --nc status "$VPN" | grep Connected` && echo 0 || echo 1);


if [ $IS_CONNECTED = 1 ]; then
  echo "⚡️| bash=`which scutil` param1=--nc param2=stop param3=$VPN terminal=false"
else
  echo "🌀| bash=$0 param1=connectVPN  terminal=false"
fi

