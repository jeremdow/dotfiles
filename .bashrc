#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LC_COLLATE="POSIX"
export EDITOR="/usr/bin/vim"

export CLICOLOR=1
alias ls='ls -h'
alias less='less -R'
export GREP_OPTIONS='--color=auto'
export GREP_COLORS='ms=48;5;235;38;5;136:mc=48;5;235;38;5;136:sl=:cx=38;5;239:fn=38;5;61:ln=38;5;64:bn=38;5;64:se=38;5;37'

man() {
    env LESS_TERMCAP_mb=$'\e[38;5;124m' \
        LESS_TERMCAP_md=$'\e[38;5;33m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[48;5;235;38;5;239m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[38;5;37m' \
        man "$@"
}

PS1='\u@\h \W \$ '

alias sudo='sudo -E'
alias vim='nvim'

# Acquia Dev Desktop (drush)
export PATH="$PATH:/Applications/DevDesktop/drush"
