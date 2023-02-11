#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

. etc/volta/init.sh

if [ ! -d $VOLTA_HOME ]
then
	echo Install volta…
	curl https://get.volta.sh | bash -s -- --skip-setup
fi

echo Linking npmrc configuration file…
append_if_exists "$HOME/.npmrc" "$HOME/.$USER-sh/etc/npm/npmrc"
ln -s "$HOME/.$USER-sh/etc/npm/npmrc" "$HOME/.npmrc"

echo Linking etc/volta/init.sh…
ln -s "$HOME/.$USER-sh/etc/volta/init.sh" "$HOME/.$USER-sh/etc/sh/profile.d/volta.sh" \
	|| echo init.sh already linked

echo Installing pnpm and node…
volta install node
volta install pnpm

echo Done!

echo exec\'ing new login shell now…
exec $SHELL -l
