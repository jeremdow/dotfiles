#
# ~/.bash_profile
#

cat /etc/motd

[[ -f ~/.bashrc ]] && . ~/.bashrc
# Leaves a second sshd and bash process running
# eval `keychain --eval --agents ssh id_rsa`
