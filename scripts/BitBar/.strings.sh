#!/usr/bin/env sh

toCamel() {
  pbpaste | awk '{$1=tolower($1)};1' |
    sed -e's/\([a-z]\)\([A-Z]\)/\1-\2/g' |
    sed -re's/ +/_/g' -e's/-+/_/g' -e's/_+/_/g' -e's/_([^a-zA-Z]*)$/\1/g' |
    perl -pe's/_([a-zA-Z0-9])/uc($1)/ge' |
    perl -pe's/^[^a-zA-Z]*[A-Z]/lc($&)/ge' |
    sed -re 's/_([^a-zA-Z]*)$/\1/g' | perl -pe 'chomp if eof' |
    pbcopy
  exit 0
}

toPascal() {
  pbpaste |  awk '{$1=tolower($1)};1' |
    sed -e's/\([a-z]\)\([A-Z]\)/\1-\2/g' |
    sed -re's/ +/_/g' -e's/-+/_/g' -e's/_+/_/g' -e's/_([^a-zA-Z]*)$/\1/g' |
    perl -pe's/_([a-zA-Z])/uc($1)/ge' |
    perl -pe's/^[^a-zA-Z]*[a-z]/uc($&)/ge' | perl -pe 'chomp if eof' |
    pbcopy
  exit 0
}

toKebab() {
  pbpaste | awk '{$1=$1};1' |
    sed -re's/([0-9]+)/-\1/g' -e's/([A-Z]+)/-\1/g' -e's/([A-Z]+)([A-Z])([^A-Z -]+)/\1-\2\3/g' |
    sed -re's/[ _-]+/-/g' -e's/_([^a-zA-Z]*)$/\1/g' |
    perl -pe's/_([a-zA-Z])/uc($1)/ge' |
    sed -re 's/^([^a-zA-Z]*)-/\1/g' |
    sed -re 's/-([^a-zA-Z]*)$/\1/g' |
    tr '[:upper:]' '[:lower:]' | perl -pe 'chomp if eof' |
    pbcopy
  exit 0
}

toSnake() {
  pbpaste | awk '{$1=$1};1' |
    sed -re's/([0-9]+)/-\1/g' -e's/([A-Z]+)/-\1/g' -e's/([A-Z]+)([A-Z])([^A-Z -]+)/\1-\2\3/g' |
    sed -re's/ +/_/g' -e's/-+/_/g' -e's/_+/_/g' |
    sed -re 's/^([^a-zA-Z]*)_/\1/g' -e's/_([^a-zA-Z]*)$/\1/g' |
    tr '[:upper:]' '[:lower:]' | perl -pe 'chomp if eof' |
    pbcopy
  exit 0
}

toTitle() {
  pbpaste | awk '{$1=$1};1' |
    sed -e's/\([a-z]\)\([A-Z]\)/\1-\2/g' |
    sed -re's/[ _-]+/ _/g' -e's/^([^a-zA-Z]*) /\1/g' -e's/ _([^a-zA-Z]*)$/\1/g' |
    perl -pe's/_([a-zA-Z])/uc($1)/ge' |
    perl -pe's/^[^a-zA-Z]*[a-z]/uc($&)/ge' | perl -pe 'chomp if eof' |
    pbcopy
  exit 0
}

toSentence() {
  pbpaste | awk '{$1=$1};1' |
    sed -e's/\([a-z]\)\([A-Z]\)/\1-\2/g' | sed -re's/[ _-]+/ _/g' -e's/^([^a-zA-Z]*) /\1/g' -e's/ _([^a-zA-Z]*)$/\1/g' |
    perl -pe's/_([a-zA-Z])/lc($1)/ge' |
    perl -pe's/^[^a-zA-Z]*[a-z]/uc($&)/ge' | perl -pe 'chomp if eof' |
    pbcopy
  exit 0
}

"$@"

echo "String"
echo "--toCamel | bash=/bin/bash param1=$0 param2=toCamel size=12 terminal=false refresh=true"
echo "--ToPascal | bash=/bin/bash param1=$0 param2=toPascal size=12 terminal=false refresh=true"
echo "--to_snake | bash=/bin/bash param1=$0 param2=toSnake size=12 terminal=false refresh=true"
echo "--to-kebab | bash=/bin/bash param1=$0 param2=toKebab size=12 terminal=false refresh=true"
echo "--To-Title | bash=/bin/bash param1=$0 param2=toTitle size=12 terminal=false refresh=true"
