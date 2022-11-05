#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing nvm…
    brew install nvm
elif is_os Linux
then
    echo Fetching tag name of latest version…
    latest=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest \
        | jq -r .tag_name)

    echo Installing nvm ${latest}…
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$latest/install.sh | bash
else
    echo Could not update nvm >&2
    exit 1
fi

echo Done!
exec $SHELL -l
