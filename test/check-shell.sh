#!/usr/bin/env sh

set -u

status=0

echo "==> zsh startup output"
output=$(TERM=xterm-256color script -q /dev/null zsh -lic exit < /dev/null 2>&1 | tr -d '\r\b' | sed 's/\^D//g' | grep -v '^[[:space:]]*$')
if [ -n "$output" ]
then
    echo "$output"
    status=1
fi

for cmd in brew git python java node pnpm mvnd
do
    echo "==> $cmd"
    if command -v "$cmd"
    then
        "$cmd" --version || status=1
    else
        echo "$cmd not found"
        status=1
    fi
done

echo "==> jenv doctor"
doctor=$(jenv doctor 2>&1)
echo "$doctor"
echo "$doctor" | grep -q ERROR && status=1

exit $status
