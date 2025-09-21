#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing dependencies…
    #brew install brew install openssl readline sqlite3 xz zlib tcl-tk@8

elif is_os Linux && is_installed apt
then
    echo Installing dependencies…
    sudo apt update
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev  \
                        libreadline-dev libsqlite3-dev wget curl llvm          \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev           \
                        libxmlsec1-dev libffi-dev liblzma-dev
else
    echo Unsupported OS >&2
    exit 1
fi

export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"

# TODO we could do like with nvm and clone only the last tag
# TODO update script
echo Cloning pyenv into ${PYENV_ROOT}…
git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"

echo Loading pyenv…
eval "$(pyenv init -)"

for v in 3
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

echo Linking pyenv configuration file…
ln -s "$HOME/.$USER-sh/etc/pyenv/rc" "$HOME/.$USER-sh/etc/sh/rc.d/pyenv.sh"

echo Done!
exec $SHELL -l
