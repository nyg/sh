#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    sudo apt update
    sudo apt install -y expect
fi

if ! is_installed python
then
    . "$HOME/.$USER-sh/install/python.sh"
fi

git clone https://github.com/kuthulux/gnome-connection-manager.git "$HOME/.local/bin/gnome-connection-manager"

echo "#!/usr/bin/env sh" > "$HOME/.local/bin/gcm.sh"
echo "nohup $HOME/.local/bin/gnome-connection-manager/gnome_connection_manager.py > /dev/null 2>&1 &" >> "$HOME/.local/bin/gcm.sh"

chmod u+x "$HOME/.local/bin/gcm.sh"
