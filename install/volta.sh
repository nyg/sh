#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"
. "$HOME/.$USER-sh/etc/volta/profile"

if [ ! -d $VOLTA_HOME ]
then
    echo Install volta…
    curl https://get.volta.sh | bash -s -- --skip-setup
fi

echo Linking npmrc configuration file…
append_if_exists "$HOME/.npmrc" "$HOME/.$USER-sh/etc/npm/npmrc"
ln -s "$HOME/.$USER-sh/etc/npm/npmrc" "$HOME/.npmrc"

echo Linking volta configuration file…
ln -s "$HOME/.$USER-sh/etc/volta/profile" "$HOME/.$USER-sh/etc/sh/profile.d/volta.sh" \
    || echo configuration file already linked

echo Installing node…
volta install node

read -p "Install pnpm? (y/N) " answer
if [ "$answer" = "y" ]
then
    echo Installing pnpm…
    volta install pnpm
    echo 'export VOLTA_FEATURE_PNPM=1' >> "$HOME/.$USER-sh/etc/volta/profile"
fi

echo Done!

echo exec\'ing new login shell now…
exec $SHELL -l
