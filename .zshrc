#
# executes commands at the start of an interactive session.
#
# authors:
#   sorin ionescu <sorin.ionescu@gmail.com>
#

# source prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
ssh-add -K ~/.ssh/id_rsa
ssh-add -K ~/.ssh/work/cw_rsa
keychain --nogui --quiet ~/.ssh/id_rsa
keychain --nogui --quiet  ~/.ssh/github/test_rsa
source ~/.keychain/$HOST-sh
 alias vi='vim'
# alias ssh='ssh'

# customize to your needs...
#
eval "$(/opt/homebrew/bin/brew shellenv)"
#complete -c 'aws_completer' aws
#fpath=('aws_completer' $fpath)
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
bindkey '^r' peco-history-selection
alias ft='find . -type d | grep -v "\/\." | peco'
alias fn='find . -name * | grep -v "\/\." | peco'
alias ag='ag -a'
alias gi='git'
alias dcp='docker-compose'


function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function rgvim () {
  vim $(rg -n $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function agp(){
  #ag $@ | awk '!a[$0]++' | peco --query "$lbuffer" | awk -f : '{print -z $1}'
  buffer=`ag $@ | awk '!a[$0]++' | peco --query "$LBUFFER" | awk -F : '{print $1}'`
  #buffer=`ag $@ | awk '!a[$0]++' | peco --query "$lbuffer"`
  print -z $BUFFER
  #cursor=$#buffer
  #cursor=$#buffer
  #zle reset-prompt
  #$(ag $@ | peco --query "$lbuffer"| awk -f : '{print "-c " $2 " " $1}')
}

function fnvim () {
  vim $(fn)
}

function describe-instances(){
  aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | [.Tags[].Value,.InstanceId,.PublicIpAddress] | @csv' | peco
}

function describe-addresses(){
  aws ec2 describe-addresses | jq -r '.Addresses[] | [.AllocationId,.AssociationId,.InstanceId,.Tags[].Value,.PublicIp] | @csv' | peco
}

#export PATH=~/bin/:~/bin/du-bin/:~/bin/vendor/:local/bin:~/usr/local/bin:"$PATH"

PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
#export PATH=$HOME/Library/Python//2.7/bin/:$PATH
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$HOME/iroiro/mycmd/:$PATH
export PATH=$HOME/.composer/vendor/squizlabs/php_codesniffer/bin:$PATH
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:$HOME/.local/bin
export QT_QPA_PLATFORM_PLUGIN_PATH=usr/local/Cellar/qt/5.13.2/plugins
export QT_PLUGIN_PATH=$QT_QPA_PLATFORM_PLUGIN_PATH
export Qt5_DIR=usr/local/Cellar/qt/5.13.2/plugins
export PATH=$PATH:$QT_QPA_PLATFORM_PLUGIN_PATH/bin
export PATH=$HOME/Library/Python/3.8/bin:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export PATH=$HOME/.nimble/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  #source "$(pyenv which aws_zsh_completer.sh)"
fi
if command -v pyenv virtualenv 1>/dev/null 2>&1; then
eval "$(pyenv virtualenv-init -)"
fi


#source $PYENV_ROOT/shims/aws_zsh_completer.sh
#complete -C aws_completer aws
[[ -d ~/.rbenv ]] && \
  export PATH=$HOME/.rbenv/bin:$PATH && \
  eval "$(rbenv init -)"
export TERM=xterm-256color
# eval "$(ssh-add --apple-use-keychain)"
# The -K and -A flags are deprecated and have been replaced
#         by the --apple-use-keychain and --apple-load-keychain
# eval "$(ssh-add -K ~/.ssh/github/test_rsa)"
export LANG=ja_JP.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/itahashitakushi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/itahashitakushi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/itahashitakushi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/itahashitakushi/google-cloud-sdk/completion.zsh.inc'; fi
# eval `$(ssh-agent)`
eval `ssh-agent`
#eval "$(hub alias -s)"

export NPM_TOKEN=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
# git-promptの読み込み
source ~/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -U compinit
compinit -u

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定(好きなようにカスタマイズ可)
setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

export NODE_PATH=$HOME/.nodebrew/current/lib/node_modules
export PATH=$PATH:~/.nodebrew/current/bin:~/.nodebrew/current/lib/node_modules/npm/bin
export PATH=$PATH:$HOME/.cargo/bin

peco-src () {
    local repo=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

ghq-code () {
    local repo=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        code ${repo}
    fi
}
zle -N ghq-code
