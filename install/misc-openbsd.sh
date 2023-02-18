#!/usr/bin/env sh

pkg_add \
    curl \
    vim \
    colorls \
    git \
    jdk \
    maven \
    zip \
    unzip

# TODO
# echo "\nexport ENV=$HOME/.shrc" >> $HOME/.profile
# ln -s $HOME/.$USER-sh/etc/shrc $HOME/.shrc

# if [ "$USR" = 'root' ]
# then
#     # Keyboard layout
#     # echo keyboard.encoding=sf > /etc/wsconsctl.conf

#     ln -s $HOME/.$USER-sh/etc/installurl /etc/installurl
# fi
