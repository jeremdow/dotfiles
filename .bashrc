#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:$HOME/bin
export LC_COLLATE="POSIX"
export EDITOR="vim"

eval "$(dircolors -b)"
alias ls='ls --color=auto'

# Pass user aliases to sudo
alias sudo='sudo '

#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

#root
#PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '

#PS1='[\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[00m\]]\$ '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[00m\] \$ '

# TMUX
if which tmux 2>&1 >/dev/null; then
    # if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)

    # when quitting tmux, try to attach
    while test -z $TMUX; do
        tmux attach || break
    done
fi
