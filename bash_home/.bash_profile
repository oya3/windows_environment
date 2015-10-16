PS1='\[\033]0;\W$(__git_ps1)\007\]\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[\0;33m\]$(__git_ps1)\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
alias ls='ls --show-control-chars --color'
alias ll='ls -la --show-control-chars --color'
LS_COLORS='di=34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
alias emacs='"C:/tools/emacs/bin/emacsclientw.exe"'

# パス追加
export PATH=$PATH:~/.emacs.d/bin

# git 設定
# source ~/.git-completion.bash
# source ~/git-prompt.sh
source /etc/git-completion.bash
source /etc/git-prompt.sh

# add されていない変更の存在を「＊」で示す
# commit されていない変更の存在を「＋」で示す
GIT_PS1_SHOWDIRTYSTATE=true
# add されていない新規ファイルの存在を「％」で示す
GIT_PS1_SHOWUNTRACKEDFILES=true
# stash がある場合は「＄」で示す
GIT_PS1_SHOWSTASHSTATE=true
# upstream と同期している場合は「＝」で示す
# upstream より進んでいる場合は「＞」で示す
# upstream より遅れている場合は「＜」で示す
GIT_PS1_SHOWUPSTREAM=auto

# proxy例外
export no_proxy=192.168.10.13
export NO_PROXY=192.168.10.13

# alias gohtml='cd ~/www/html'
# alias gowww='cd ~/www'
