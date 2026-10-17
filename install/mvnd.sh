#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux
then
    echo Fetching URL of latest mvnd version…
    download_url=$(curl -s https://api.github.com/repos/apache/maven-mvnd/releases/latest \
        | jq -r '.assets[] | select(.name | test("-linux-amd64.zip$")) | .browser_download_url')
elif is_os Darwin
then
    echo Fetching URL of latest mvnd version…
    if  [ "$(uname -m)" = "x86_64" ]
    then
        download_url=$(curl -s https://api.github.com/repos/apache/maven-mvnd/releases/latest \
            | jq -r '.assets[] | select(.name | test("-darwin-amd64.zip$")) | .browser_download_url')
    elif [ "$(uname -m)" = "arm64" ]
    then
        download_url=$(curl -s https://api.github.com/repos/apache/maven-mvnd/releases/latest \
            | jq -r '.assets[] | select(.name | test("-darwin-aarch64.zip$")) | .browser_download_url')
    else
        echo macOS architecture not supported! >&2
        exit 1
    fi
else
    echo OS is not supported! >&2
    exit 1
fi

mvnd_dir="$HOME/.local/opt/mvnd"

echo Downloading mvnd from "$download_url"…
(cd /tmp; curl -Lo mvnd.zip "$download_url")

if [ ! -f /tmp/mvnd.zip ]
then
    echo Download failed! >&2
    exit 1
fi

echo Removing previous version…
rm -rf "$mvnd_dir"

echo Extracting archive…
unzip /tmp/mvnd.zip -d "$(dirname "$mvnd_dir")"
rm /tmp/mvnd.zip
mv "$(dirname "$mvnd_dir")"/maven-mvnd-* "$mvnd_dir"

echo Linking launcher to "$HOME/.local/bin/mvnd"…
ln -sf "$mvnd_dir/bin/mvnd.sh" "$HOME/.local/bin/mvnd"

echo Done!
