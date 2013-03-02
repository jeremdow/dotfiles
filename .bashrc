#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:$HOME/bin
export LC_COLLATE="POSIX"
export EDITOR="/usr/bin/vim"

eval "$(dircolors -b)"
alias ls='ls --color=auto'

alias sudo='sudo '
#(pass user aliases to sudo)

alias drush='php ~/drush/drush.php'

PS1='[\u@\h \W]\$ '
