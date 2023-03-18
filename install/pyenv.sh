#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

export PYENV_ROOT="$HOME/.config/pyenv"

if is_os Darwin
then
    echo Installing pyenv…
    brew install pyenv

elif is_os Linux && is_installed apt
then
    PATH="$PATH:$PYENV_ROOT/bin"

    echo Installing dependencies…
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev  \
                        libreadline-dev libsqlite3-dev wget curl llvm          \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev           \
                        libxmlsec1-dev libffi-dev liblzma-dev

    echo Installing pyenv…
    curl https://pyenv.run | bash

else
    echo Could not install pyenv >&2
    exit 1
fi

for v in 2 3
do
    if is_os Darwin
    then
        latest=$(pyenv install -l | grep -e "^\s*$v\.\d*\.\d*$" | tail -1 | sed 's/ *//')
    else
        latest=$(pyenv install -l | grep -P "^\s*$v\.\d*\.\d*$" | tail -1 | sed 's/ *//')
    fi

    echo Installing version ${latest}…
    pyenv install $latest
done

echo Setting version 3 as the global one…
pyenv rehash
pyenv global 3

echo Linking pyenv configuration files…
ln -s "$HOME/.$USER-sh/etc/pyenv/profile" "$HOME/.$USER-sh/etc/sh/profile.d/pyenv.sh"
ln -s "$HOME/.$USER-sh/etc/pyenv/rc" "$HOME/.$USER-sh/etc/sh/rc.d/pyenv.sh"

echo Done!
exec $SHELL -l
