#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:$HOME/bin
export LC_COLLATE="POSIX"
export EDITOR="vim"
export PAGER="vimpager"

eval "$(dircolors -b)"
alias ls='ls --color=auto'

# Pass user aliases to sudo
alias sudo='sudo '

PS1='[\u@\h \W]\$ '
