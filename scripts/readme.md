Tips and Tricks about script

### SSH key for 2 Github separate account

```sh
PERS_ID_RSA="personal-id_rsa"
GROUP_ID_RSA="group-id_rsa"
cat << EOF >> ~/.ssh/config
Host ssh.github.com
  Hostname ssh.github.com
  Port 443
  User git
  IdentityFile ~/.ssh/$GROUP_ID_RSA
  #  LogLevel DEBUG

Host github.com
  Hostname ssh.github.com
  Port 443
  User git
  IdentityFile ~/.ssh/@PERS_ID_RSA
  #  LogLevel DEBUG
EOF
```
```sh
PERS="personal"
GROUP="group"

cat << EOF >> ~/.git/.gitconfig
[url "git@ssh.github.com:$PERS"]
  insteadOf = https://github.com/$PERS
[url "git@ssh.github.com:$GROUP"]
 insteadOf = https://github.com/$GROUP
[url "git@ssh.github.com:$GROUP"]
 insteadOf = git://github.com/$GROUP
EOF
```

### Init SRE Tools
1. Init tools for `SRE's pod`

```sh
devspace -n sre enter -- bash -c "
  apt install -y openssh-server netcat-openbsd;
  sed -i -e 's/#Port 22/Port 2300/g' /etc/ssh/sshd_config;
  mkdir -p ~/.ssh; echo $(cat ~/.ssh/id_rsa.pub) >> ~/.ssh/authorized_keys;
  service ssh start";
  
cat << EOF >> ~/.ssh/config
Host sre.tools
  Hostname 127.0.0.1
  User root
  Port 2300
  ProxyCommand devspace -n sre enter -- nc localhost 2300
  IdentitiesOnly yes
EOF
```