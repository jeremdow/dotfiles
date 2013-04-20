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

PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
#PS1='[\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[00m\]]\$ '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[00m\] \$ '

# TMUX
if which tmux 2>&1 >/dev/null; then
	#if not inside a tmux session, and if no session is started, start a new session
	test -z "$TMUX" && (tmux attach || tmux new-session)
fi
