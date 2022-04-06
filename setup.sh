#!/bin/sh
echo "### Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "### Installing zsh"
brew install zsh

echo "###   Set up Oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "### Installing zsh-completions"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "### Installing zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

echo "### Installing zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

echo "### Installing history-search-multi-word"
git clone https://github.com/zdharma/history-search-multi-word.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/history-search-multi-word

echo "### Installing theme"
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme" >>! ~/.zshrc

echo "### Edit .zshrc content..."
# echo "source $PWD/.zshrc" > ~/.zshrc
ln -s "${0%/*}"/.zsh* ~/
echo "ZSH eco-sys setup done!"

echo "Installing hack-nerd-font"
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
# sed -i "1s#^#source $PWD/.zshrc && return 0\n/" ~/.zshrc

echo "Setting up tools..."
brew install oath-toolkit

echo "Install OpenVPN"
brew install openvpn
sudo sh -c "echo \"`whoami`\t\tALL = (ALL) NOPASSWD: `which pkill`, `which openvpn`, \" > /etc/sudoers.d/vpn_permit"

echo "Install colorls"
sudo gem install colorls

echo "Install SpaceVim"
curl -sLf https://spacevim.org/install.sh | bash
mkdir ~/.SpaceVim.d && ln -s "${0%/*}"/spacevim/init.toml ~/.SpaceVim.d