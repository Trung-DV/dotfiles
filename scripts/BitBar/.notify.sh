
displayNotification() {
  title=$1
  content=$2
  osascript -e "display notification \"$content\" with title \"$title\""
}

"$@"
