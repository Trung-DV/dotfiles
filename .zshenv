# GOPATH=$HOME/go
#export GOROOT=`go env GOROOT`
# export NODE_PATH=/usr/local/lib/node_modules
PATH=$PATH:$HOME/go/bin:/Applications/MySQLWorkbench.app/Contents/MacOS:/Applications/Pritunl.app/Contents/Resources
EDITOR='code --wait'
export GITHUB_TOKEN=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
alias lc='colorls -lA --sd'

# export NOMAD_ADDR=http://10.30.83.2:4646

#export NOMAD_ADDR=http://service-any.dop-staging.tsengineering.io:9988

<< 'MULTILINE-COMMENT' > /dev/null
    Config for zsh history size and file
    Ref:
    - https://github.com/bamos/zsh-history-analysis/blob/master/README.md
    - https://www.soberkoder.com/better-zsh-history/
MULTILINE-COMMENT

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
