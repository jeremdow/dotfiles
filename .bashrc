#
# ~/.bashrc
#

# Check for an interactive session
[ -z "$PS1" ] && return

PATH=$PATH:$HOME/bin
export LC_COLLATE="POSIX"
export EDITOR="/usr/bin/vim"

eval "$(dircolors -b)"
alias ls='ls --color=auto'

alias sudo='sudo '
alias drush='php ~/drush/drush.php'

PS1='[\u@\h \W]\$ '
