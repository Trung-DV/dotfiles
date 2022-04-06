
# export EDITOR='vim'
#EDITOR='code --wait'

# alias cat=ccat
#alias kraken="open -na 'GitKraken' --args -p $(pwd)"
#alias kubectl='kubectl --kubeconfig ~/.kube/kube_config_rancher-cluster.yml'
# Docker-compose
# alias dco='docker-compose'

# alias dcb='docker-compose build'
# alias dce='docker-compose exec'
# alias dcps='docker-compose ps'
# alias dcrestart='docker-compose restart'
# alias dcrm='docker-compose rm'
# alias dcr='docker-compose run'
# alias dcstop='docker-compose stop'
# alias dcup='docker-compose up'
# alias dcupd='docker-compose up -d'
# alias dcdn='docker-compose down'
# alias dcl='docker-compose logs'
# alias dclf='docker-compose logs -f'
# alias dcpull='docker-compose pull'
# alias dcstart='docker-compose start'
####################################################################

# source $(dirname $(gem which colorls))/tab_complete.sh
#alias lc='colorls -lA --sd'
#alias cat='ccat'

if [ -f /usr/local/bin/kubectl.docker ]; then
  echo "y" | rm /usr/local/bin/kubectl.docker >/dev/null
fi

#unalias gops
