#!/usr/bin/env bash

# JSON Utils: Validate, format and compact JSON entity from clipboard and then write to clipboard
#
# by Cnfn (http://github.com/cnfn)
#
# <bitbar.title>JSON Utils</bitbar.title>
# <bitbar.version>v1.4</bitbar.version>
# <bitbar.author>Cnfn</bitbar.author>
# <bitbar.author.github>cnfn</bitbar.author.github>
# <bitbar.desc>Validate, format and compact JSON entity from clipboard and then write to clipboard. More info: https://github.com/cnfn/BitBarPlugins/tree/master/JsonUtils</bitbar.desc>
# <bitbar.image>https://raw.githubusercontent.com/cnfn/grocery/master/images/blog/bitbar_plugin_json_utils_main.png</bitbar.image>
# <bitbar.dependencies>bash,jq</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/cnfn/BitBarPlugins/tree/master/JsonUtils</bitbar.abouturl>
#
# Dependencies:
#   jq (https://stedolan.github.io/jq/)

export PATH=$PATH:/usr/local/bin

# Hack for language not being set properly and unicode support
export LANG="${LANG:-en_US.UTF-8}"

notifyJsonTitle="JsonUtils"
notifyValidJson="Valid JSON, type:"
notifyInvalidJson="Invalid JSON !!!!!!!!!!"

displayNotification() {
  title=$1
  content=$2
  bash ${0%/*}/.notify.sh displayNotification $title $content
}

doValidateJson() {
  typeName=$(pbpaste | jq -r | jq type 2>/dev/null | xargs echo -n 2>/dev/null)
  if [[ "object" == "$typeName" || "array" == "$typeName" ]]; then
    echo "$typeName"
  else
    echo ""
  fi
}

notifyAndExitWhenInvalidJson() {
  typeName=$(doValidateJson)
  [ -n "$typeName" ] || {
    osascript -e "beep"
    displayNotification $notifyJsonTitle "$notifyInvalidJson"
    exit 1
  }
}

validateJson() {
  typeName=$(doValidateJson)
  if [[ -n "$typeName" ]]; then
    displayNotification $notifyJsonTitle "$notifyValidJson $typeName"
  else
    osascript -e "beep"
    displayNotification $notifyJsonTitle "$notifyInvalidJson"
  fi
}

formatJson() {
  notifyAndExitWhenInvalidJson

  pbpaste | jq -r | jq . --indent 2 | pbcopy
  displayNotification $notifyJsonTitle "Formatted"
}

sortJson() {
  notifyAndExitWhenInvalidJson

  pbpaste | jq -r | jq -S . | pbcopy
  displayNotification $notifyJsonTitle "Sorted"
}
parseJson() {
  notifyAndExitWhenInvalidJson

  node -e "console.log(JSON.parse(`pbpaste`))" | pbcopy
  displayNotification $notifyJsonTitle "Parsed"
}

compactJson() {
  notifyAndExitWhenInvalidJson

  pbpaste | jq -r | jq . --compact-output | pbcopy
  displayNotification $notifyJsonTitle "Compacted"
}

jsonToYaml() {
  notifyAndExitWhenInvalidJson

  pbpaste | yq e -P - | pbcopy
  displayNotification $notifyJsonTitle "Converted to Yaml"
}

jsonToProp() {
  notifyAndExitWhenInvalidJson

  pbpaste | yq e -o=p | pbcopy
  displayNotification $notifyJsonTitle "Converted to Yaml"
}

notifyYamlTitle="YamlUtils"
notifyValidYaml="Valid YAML"
notifyInvalidYaml="Invalid YAML !!!!!!!!!!"

doValidateYaml() {
  result=$(pbpaste | yq v -)
  echo "$result"
}

notifyAndExitWhenInvalidYaml() {
  typeName=$(doValidateYaml)
  [ -z "$typeName" ] || {
    osascript -e "beep"
    displayNotification $notifyYamlTitle "$notifyInvalidYaml"
    exit 1
  }
}

validateYaml() {
  typeName=$(doValidateYaml)
  if [[ -z "$typeName" ]]; then
    displayNotification $notifyYamlTitle "$notifyValidYaml $typeName"
  else
    osascript -e "beep"
    displayNotification $notifyYamlTitle "$notifyInvalidYaml"
  fi
}

sortYaml() {
  notifyAndExitWhenInvalidYaml

  pbpaste | yq e -o j - | jq -S . | yq e -P - | pbcopy
  displayNotification $notifyYamlTitle "Sorted"
}

yamlToJson() {
  notifyAndExitWhenInvalidYaml

  pbpaste | yq e -o j --prettyPrint - | pbcopy
  displayNotification $notifyYamlTitle "Converted to Json"
}

yamlToProp() {
  notifyAndExitWhenInvalidYaml

  pbpaste | yq e -o=p | pbcopy
  displayNotification $notifyYamlTitle "Converted to Properties"
}

propToJson() {
  notifyAndExitWhenInvalidYaml

  pbpaste |
    sed 's/[[:space:]]*=[[:space:]]*/=/' |
    sed 's/[[:space:]]*$//' |
    sed '/^$/d' |
    jq -R -s 'split("\n") | map(split("=")) | map({(.[0]): .[1]}) | add' | pbcopy
  displayNotification $notifyYamlTitle "Converted to Properties"
}

#cat prop.properties | sed 's/[[:space:]]*=[[:space:]]*/=/' |  sed 's/[[:space:]]*$//' |  sed '/^$/d' | jq -R -s 'split("\n") | map(split("=")) | map({(.[0]): .[1]}) | add'
# call function: validate, format, compact
[ $# == 1 ] && {
  $1
  exit 0
}

#echo "Type | size=12 color=orange"
#echo "---"
echo "JSON | size=12 color=cadetblue"
echo "--Validate | bash='$0' param1=validateJson terminal=false"
echo "--Format | bash='$0' param1=formatJson terminal=false"
echo "--Sort | bash='$0' param1=sortJson terminal=false"
echo "--Parse | bash='$0' param1=parseJson terminal=false"
echo "--Compact | bash='$0' param1=compactJson terminal=false"
echo "--To Yaml | bash='$0' param1=jsonToYaml terminal=false"
echo "--To Prop | bash='$0' param1=jsonToProp terminal=false"
echo "---"
echo "YAML | size=12 color=green"
echo "--Validate | bash='$0' param1=validateYaml terminal=false"
echo "--Sort | bash='$0' param1=sortYaml terminal=false"
echo "--To Json | bash='$0' param1=yamlToJson terminal=false"
echo "--To Prop | bash='$0' param1=yamlToProp terminal=false"
#echo "---"
#echo "Properties | size=12"
#echo "--Validate | bash='$0' param1=validateYaml terminal=false"
#echo "--Sort | bash='$0' param1=sortYaml terminal=false"
#echo "--To Json | bash='$0' param1=propToJson terminal=false"
#echo "--To Prop | bash='$0' param1=yamlToProp terminal=false"
