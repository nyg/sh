#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing gnupg and pinentry…
    brew install gnupg pinentry-mac
else
    echo Unsupported OS >&2
    exit 1
fi

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
echo Creating GPG home directory in ${GNUPGHOME}…
mkdir -p "$GNUPGHOME"
chmod 700 $GNUPGHOME

echo Linking configuration files…
ln -s "$HOME/.$USER-sh/etc/gpg/agent.conf" "$GNUPGHOME/gpg-agent.conf"
ln -s "$HOME/.$USER-sh/etc/gpg/rc" "$HOME/.$USER-sh/etc/sh/rc.d/gpg.sh"

echo Restarting gpg-agent…
killall gpg-agent

echo Done!
