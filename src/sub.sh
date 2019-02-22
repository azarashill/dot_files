#!/bin/zsh

cd $(dirname $0)

git clone git://github.com/zsh-users/zsh-completions.git

if [ "$(grep 'fpath' ~/.zshrc)" = "" ]; then
  echo "fpath=($PWD/zsh-completions '\$fpath')" >> ./.zshrc
  echo "autoload -U compinit" >> ./.zshrc
  echo "compinit -u" >> ./.zshrc
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

$PWD/src/setopt.sh

chsh -s $(which zsh)

#cloneする
git clone https://github.com/powerline/fonts.git --depth=1

# インストール
cd fonts
install.sh

# 必要なければcloneファイルを削除
cd ..
rm -rf fonts


