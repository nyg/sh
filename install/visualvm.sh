#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

download_url=$(curl -s https://api.github.com/repos/oracle/visualvm/releases/latest \
   | jq -r '.assets[] | select(.name | test("visualvm.*zip")) | .browser_download_url')
echo Downloading VisualVM from $download_url…

(cd /tmp; curl -Lo visualvm.zip "$download_url")

if [ ! -f /tmp/visualvm.zip ]
then
    echo Download failed! >&2
    exit 1
fi

echo Unzipping VisualVM in "$HOME/.$USER-sh/softwares/"
mkdir -p "$HOME/.$USER-sh/softwares/"
unzip /tmp/visualvm.zip -d "$HOME/.$USER-sh/softwares/"
rm /tmp/visualvm.zip

echo Linking executable to "$HOME/.local/bin/visualvm"…
mkdir -p "$HOME/.local/bin"
ln -s "$HOME"/".$USER-sh"/softwares/visualvm*/bin/visualvm "$HOME/.local/bin/visualvm"

echo Done!
