#!/usr/bin/env sh
# https://www.jetbrains.com/toolbox-app/
# https://www.jetbrains.com/help/idea/installation-guide.html#fe5cb000

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Installing dependencies…
    sudo apt install -y libfuse2 libxi6 libxrender1 libxtst6 mesa-utils \
        libfontconfig libgtk-3-bin

    echo Installing JetBrains Toolbox…
    curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh \
        | bash

else
    echo Could not install JetBrains Toolbox >&2
    exit 1
fi

echo Done!
