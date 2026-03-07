#!/usr/bin/env sh

set -eu

git -C $NVM_DIR fetch --tags origin

last_tag=$(git -P -C $NVM_DIR tag --sort=taggerdate | tail -1)
git -C $NVM_DIR -c advice.detachedHead=false co $last_tag

echo Done!
exec $SHELL -l
