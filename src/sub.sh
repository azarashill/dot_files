#!/bin/zsh

cd $(dirname $0)

git clone git://github.com/zsh-users/zsh-completions.git

if [ "$(grep 'fpath' ~/.bashrc)" = "" ]; then
  test="fpath=($PWD/zsh-completions "
  test+='$fpath)'
  echo $test >> ./.zshrc
  echo "autoload -U compinit" >> ./.zshrc
  echo "compinit -u" >> ./.zshrc
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s $(which zsh)

cloneする
git clone https://github.com/powerline/fonts.git --depth=1

# インストール
cd fonts
install.sh

# 必要なければcloneファイルを削除
cd ..
rm -rf fonts


