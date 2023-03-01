#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

echo Cloning zsh-defer…
git clone --depth=1 https://github.com/romkatv/zsh-defer.git "$HOME/.$USER-sh/softwares/zsh-defer"

echo Done!
exec $SHELL
