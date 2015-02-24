#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

GOPATH=$HOME/go
PATH=$HOME/bin:$GOPATH/bin:$PATH

export LC_COLLATE="POSIX"
export EDITOR="/usr/bin/vim"

#eval "$(dircolors -b)"
eval "$(dircolors ~/.dircolors)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias less='less -R'
export GREP_COLORS="ms=48;5;235;38;5;136:mc=48;5;235;38;5;136:sl=:cx=38;5;239:fn=38;5;61:ln=38;5;64:bn=38;5;64:se=38;5;37"

man() {
    env LESS_TERMCAP_mb=$'\e[38;5;124m' \
        LESS_TERMCAP_md=$'\e[38;5;33m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_ms=$'\E[48;5;235;38;5;136m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[48;5;235;38;5;136m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[38;5;37m' \
        man "$@"
}

PS1='\u@\h \W \$ '
#PROMPT_COMMAND='printf "\033k$(hoe[38;5;37mme -s)\033\\"'
PROMPT_COMMAND='printf "\033]0;""$PWD""\007" | sed "s|$HOME|~|"'

alias sudo='sudo -E'

# iproute2 deprecated networking commands
alias arp='ip n' #(ip neighbor)
alias ifconfig='ip a' #(ip addr), ip link, ip -s (ip -stats)
alias iptunnel='ip tunnel'
alias iwconfig='iw'
alias nameif='ip link' #ifrename
alias netstat='ss' #ss, ip route (for netstat-r), ip -s link (for netstat -i), ip maddr (for netstat-g)
alias route='ip r' #(ip route)
