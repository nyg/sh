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

for cmd in brew git python java node pnpm mvnd gpg mariadb
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

for app in mvnd visualvm
do
    echo "==> $app in ~/.local/opt"
    target=$(readlink "$HOME/.local/bin/$app")
    echo "$target"
    case $target in
        "$HOME/.local/opt/$app/"*) [ -x "$target" ] || status=1 ;;
        *) status=1 ;;
    esac
done

echo "==> zsh-defer"
zsh -ic 'whence -w zsh-defer' < /dev/null || status=1

echo "==> brew cron job"
crontab -l
cron_path=$(crontab -l | sed -n 's/^PATH=//p')
PATH="$cron_path" command -v brew || status=1

echo "==> jenv doctor"
doctor=$(jenv doctor 2>&1)
echo "$doctor"
echo "$doctor" | grep -q ERROR && status=1

exit $status
