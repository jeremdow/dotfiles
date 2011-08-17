[[ -f ~/.bashrc ]] && . ~/.bashrc

# Disable keychain for gnome
eval `keychain --eval --agents ssh id_rsa`

if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]
then
    #xinit gnome > /dev/null 2>&1
    xinit > /dev/null 2>&1
    exit
fi
