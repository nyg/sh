#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Updating nvm…
    brew upgrade nvm
elif is_os Linux
then
    git -C $NVM_DIR fetch --tags origin

    last_tag=$(git -P -C $NVM_DIR tag --sort=taggerdate | tail -1)
    git -C $NVM_DIR -c advice.detachedHead=false co $last_tag
else
    echo Could not update nvm >&2
    exit 1
fi

echo Done!
exec $SHELL -l
