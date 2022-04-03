#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

# also check for linux?
if ! is_installed apt
then
    sudo apt install -y expect
fi

if ! is_installed python
then
    . "$HOME/.$USER-sh/install/python.sh"
fi

git clone https://github.com/kuthulux/gnome-connection-manager.git "$HOME/.local/bin/gnome-connection-manager"

echo ./gnome-connection-manager.py > "$HOME/.local/bin/gmc.sh"
chmod u+x "$HOME/.local/bin/gmc.sh"
