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

if is_os Darwin
then
    echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" > "$GNUPGHOME/gpg-agent.conf"
fi

echo Linking configuration file…
ln -s "$HOME/.$USER-sh/etc/gpg/rc" "$HOME/.$USER-sh/etc/sh/rc.d/gpg.sh"

echo Reloading gpg-agent…
gpgconf --reload gpg-agent || echo Could not restart gpg-agent

echo Done!
