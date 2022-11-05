#!/usr/bin/env sh

OS=`uname`
USR=`whoami`

if [ "$OS" = 'OpenBSD' ]
then
    echo "\nexport ENV=$HOME/.shrc" >> $HOME/.profile
    ln -s $HOME/.$USER-sh/config/shrc $HOME/.shrc

    if [ "$USR" = 'root' ]
    then
        # Keyboard layout
        # echo keyboard.encoding=sf > /etc/wsconsctl.conf

        ln -s $HOME/.$USER-sh/config/installurl /etc/installurl
        pkg_add curl vim colorls git jdk maven zip unzip
    fi
fi
