#!/usr/bin/env sh
# TODO redo install without github script
# wait for https://youtrack.jetbrains.com/issue/TBX-8561/Native-build-for-Linux-ARM64
# https://www.jetbrains.com/toolbox-app/
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# curl https://download.jetbrains.com/product?code=TBA&latest&distribution=linuxARM64 then tar xvf...

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

    echo Done!
else
    echo Could not install JetBrains Toolbox >&2
    exit 1
fi
