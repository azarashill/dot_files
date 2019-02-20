# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#------------------------------------------------------------
#  general
#------------------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

umask 022

#------------------------------------------------------------
#  history - ヒストリ
#------------------------------------------------------------

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
#shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

#ヒストリのシェル間での共有
function share_history {  # 以下の内容を関数として定義
  history -a  # .bash_historyに前回コマンドを1行追記
  history -c  # 端末ローカルの履歴を一旦消去
  history -r  # .bash_historyから履歴を読み込み直す
}

PROMPT_COMMAND='share_history'  # 上記関数をプロンプト毎に自動実施
shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
export HISTSIZE=50000
export HISTFILESIZE=50000

#------------------------------------------------------------
#  aliases - エイリアス
#------------------------------------------------------------

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='egrep -i --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cl='clear'

if [ -f /usr/bin/ack-grep ]; then
    alias ack='ack-grep -a'
fi

#------------------------------------------------------------
#  completion - 補完
#------------------------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#大文字小文字を無視
shopt -s nocaseglob
bind "C-N":menu-complete
bind "C-P":menu-complete-backward

# git
export GIT_PS1_SHOWDIRTYSTATE=1

#directory-completion with tail-slash
set mark-directories on

#------------------------------------------------------------
#  key bindings - キー設定
#------------------------------------------------------------

#disable C-s on bash
stty stop undef

#set vi mode
set -o vi

#------------------------------------------------------------
#  colors and prompt - 色・プロンプト
#------------------------------------------------------------
COLOR_RESET="\[\033[00m\]"

COLOR_BLACK="\[\033[0;30m\]"
COLOR_BLUE="\[\033[0;34m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_CYAN="\[\033[0;36m\]"
COLOR_RED="\[\033[0;31m\]"
COLOR_PURPLE="\[\033[0;35m\]"
COLOR_LIGHT_GRAY="\[\033[0;37m\]"
COLOR_DARK_GRAY="\[\033[1;30m\]"
COLOR_LIGHT_BLUE="\[\033[1;34m\]"
COLOR_LIGHT_GREEN="\[\033[1;32m\]"
COLOR_LIGHT_CYAN="\[\033[1;36m\]"
COLOR_LIGHT_RED="\[\033[1;31m\]"
COLOR_LIGHT_PURPLE="\[\033[1;35m\]"
COLOR_YELLOW="\[\033[1;33m\]"
COLOR_WHITE="\[\033[1;37m\]"

HOST_COLOR=$COLOR_LIGHT_CYAN
USER_COLOR=$COLOR_LIGHT_RED
PROMPT_COLOR=$COLOR_WHITE

case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    linux) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      color_prompt=yes
    else
      color_prompt=
    fi
fi

# color definition
if [ -f "$HOME/.bash_colors" ]; then
  . "$HOME/.bash_colors"
fi

# local color definition
if [ -f "$HOME/.bash_local" ]; then
  . "$HOME/.bash_local"
fi


if [ "$color_prompt" = yes ]; then
    . $BASH_COMPLETION_DIR/git-completion.bash
    . $BASH_COMPLETION_DIR/git-prompt.sh
    export PS1='\[\033k\033\\\]'"$USER_COLOR\u$HOST_COLOR@\h$COLOR_RESET:$PROMPT_COLOR\w$COLOR_YELLOW"'$(__git_ps1)'"$COLOR_RESET\$ "
  if [ -f $BASH_COMPLETION_COMPAT_DIR/git-prompt ]; then
    export PS1='\[\033k\033\\\]'"$USER_COLOR\u$HOST_COLOR@\h$COLOR_RESET:$PROMPT_COLOR\w$COLOR_YELLOW"'$(__git_ps1)'"$COLOR_RESET\$ "
  else
    export PS1='\[\033k\033\\\]'"$USER_COLOR\u$HOST_COLOR@\h$COLOR_RESET:$PROMPT_COLOR\w$COLOR_RESET\$ "
  fi
else
  export PS1="\u@\h\[\033[01;33m\] \w \n\$$COLOR_RESET "
fi

unset color_prompt force_color_prompt

#------------------------------------------------------------
#  language and charcode - 言語・文字コード
#------------------------------------------------------------

LANG=ja_JP.UTF-8
export VTE_CJK_WIDTH=wide

#------------------------------------------------------------
#  execution path - 実行パス
#------------------------------------------------------------

export PATH=~/bin/:~/bin/du-bin/:~/bin/vendor/:local/bin:~/usr/local/bin:"$PATH"



