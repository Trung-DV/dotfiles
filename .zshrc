
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

#http://zsh.sourceforge.net/Guide/zshguide04.html
bindkey -e
bindkey \^U backward-kill-line

export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"


# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  gem
  colorize
  git gitfast
  gcloud
  golang
  docker
  # docker-machine
  docker-compose
  zsh-autosuggestions
  history-search-multi-word
  zsh-syntax-highlighting
  # git-flow-avh
  mvn
  zsh-completions
  # kubectl make zsh slow
)
# DISABLE_MAGIC_FUNCTIONS=true
unset zle_bracketed_paste
source $ZSH/oh-my-zsh.sh

[[ ${TERM_PROGRAM} == "iTerm.app" ]] && test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

DIR=$(readlink ${(%):-%x})
DIR=${DIR%/*}

. $DIR/alias-func.sh
. $DIR/theme.sh
. $DIR/useful-functions.sh

if [[ "$ZPROF" = true ]]; then
  zprof
fi
export GPG_TTY=$(tty)
