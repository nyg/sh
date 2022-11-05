#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Installing dependencies…
    sudo apt update
    sudo apt install -y expect
fi

if ! is_installed python
then
    echo Installing Python…
    . "$HOME/.$USER-sh/install/python.sh"
fi

echo Cloning gcm repository…
git clone https://github.com/kuthulux/gnome-connection-manager.git "$HOME/.local/bin/gnome-connection-manager"

echo Creating launcher…
launcher="$HOME/.local/bin/gcm.sh"
echo "#!/usr/bin/env sh" > "$launcher"
echo 'nohup $HOME/.local/bin/gnome-connection-manager/gnome_connection_manager.py > /dev/null 2>&1 &' >> "$launcher"
chmod u+x "$launcher"

echo Done!
