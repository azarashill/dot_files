#!/bin/sh
#
#https://qiita.com/yoza/items/2f8bd33a18225754f346
#https://qiita.com/Angelan1720/items/60431c85592fe90fcdd5
#https://gist.github.com/juno/5546198
#https://qiita.com/bake0937/items/79e350a474c1cd60a5e0

#この辺り参照。



cd $(dirname $0)

#dotfile関連設定
for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ]
  then
    ln -Fs "$PWD/$dotfile" $HOME
  fi
done



#dein
mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
git clone https://github.com/Shougo/dein.vim.git \
    ~/.vim/dein/repos/github.com/Shougo/dein.vim



#zsh-completions
git clone git://github.com/zsh-users/zsh-completions.git

cd $(dirname $0)
echo "fpath=($PWD/zsh-completions $fpath)" >> ./.zshrc
echo "autoload -U compinit" >> ./.zshrc
echo "compinit -u" >> ./.zshrc


#zsh
#なんかエラー出るから最後(brewに関してはアレ)
#brew install zsh
#chsh -s /usr/local/bin/zsh
#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

#setopt EXTENDED_GLOB
#for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#done

#echo "zstyle ':prezto:module:prompt' theme 'agnoster'" >> ~/.zpreztorc

#source ~/.zpreztorc

# cloneする
#git clone https://github.com/powerline/fonts.git --depth=1

# インストール
#cd fonts
#./install.sh

# 必要なければcloneファイルを削除
#cd ..
#rm -rf fonts
