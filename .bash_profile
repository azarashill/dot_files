# Export environment variable


# Call common bashrc
source ~/.bashrc

# Call local bashrc
if [ `uname` = "Darwin" ]; then
  # for OSX
  if [ -f ~/.bash_profile.osx ]; then
    source ~/.bashrc.osx
  fi
elif [ `uname` = "Linux" ]; then
  # for Linux
  if [ -f ~/.bash_profile.linux ]; then
    source ~/.bashrc.linux
  fi
fi

. "$HOME/.cargo/env"
