#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

keychain --nogui --quiet ~/.ssh/id_rsa
source ~/.keychain/$HOST-sh
 alias vi='vim'

# Customize to your needs...
#

fpath=(/usr/local/var/homebrew/linked/zsh-completions $fpath)
autoload -U compinit
compinit -u
#alias ssh-config-update="cat ~/.ssh/conf.d/common-config ~/.ssh/conf.d/*.conf > ~/.ssh/config"

#`bindkey "\e[3~" delete-char` 

function peco-history-selection() {
  BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
alias ft='find . -type d | grep -v "\/\." | peco'
alias fn='find . -name * | grep -v "\/\." | peco'
alias ag='ag -a'
alias gi='git'


function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function agp(){
  BUFFER=`ag $@ | awk '!a[$0]++' | peco --query "$LBUFFER" | awk -F : '{print $1}'`
  print -z $BUFFER
  echo 'hoge'
  echo $#BUFFER
}

function fnvim () {
  vim $(fn)
}

#export PATH=~/bin/:~/bin/du-bin/:~/bin/vendor/:local/bin:~/usr/local/bin:"$PATH"

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH

