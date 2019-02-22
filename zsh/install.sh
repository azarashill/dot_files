#!/bin/sh

cd $(dirname $0)
if [ `uname` = "Darwin" ]; then
  # for OSX
  ruby -e "$(curl -fsSL https://raw.zshhubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew install zsh
  sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh
elif [ `uname` = "Linux" ]; then
  # for Linux
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install zsh
fi


