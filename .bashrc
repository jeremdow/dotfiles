
# Check for an interactive session
[ -z "$PS1" ] && return

PATH=$PATH:$HOME/bin
export LC_COLLATE="POSIX"
export EDITOR="/usr/bin/vim"

eval "$(dircolors -b)"
alias ls='ls --color=auto'

alias sudo='sudo '
alias surf='surf -p'

PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
