. $HOME/.bashrc
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]
then
    xinit > /dev/null 2>&1
    exit
fi
