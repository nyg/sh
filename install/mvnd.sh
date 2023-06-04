#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux
then
    echo Fetching URL of latest mvnd version…
    download_url=$(curl -s https://api.github.com/repos/apache/maven-mvnd/releases/latest \
        | jq -r '.assets[] | select(.name | test(".*-m39-linux-amd64.zip")) | .browser_download_url')
elif is_os Darwin
then
    echo Fetching URL of latest mvnd version…
    download_url=$(curl -s https://api.github.com/repos/apache/maven-mvnd/releases/latest \
        | jq -r '.assets[] | select(.name | test(".*-m39-darwin-amd64.zip")) | .browser_download_url')
else
    echo OS is not supported! >&2
    exit 1
fi

echo Downloading mvnd from "$download_url"…
(cd /tmp; curl -Lo mvnd.zip "$download_url")

if [ ! -f /tmp/mvnd.zip ]
then
    echo Download failed! >&2
    exit 1
fi

echo Removing previous version…
rm -rf "$HOME/.$USER-sh/softwares/mvnd"

echo Extracting archive…
unzip /tmp/mvnd.zip -d "$HOME/.$USER-sh/softwares/"
rm /tmp/mvnd.zip
mv "$HOME"/".$USER-sh"/softwares/maven-mvnd-* "$HOME/.$USER-sh/softwares/mvnd"

echo Linking launcher to "$HOME/.local/bin/mvnd"…
ln -s "$HOME/.$USER-sh/softwares/mvnd/bin/mvnd" "$HOME/.local/bin/mvnd" || echo Link already exists

echo Done!
