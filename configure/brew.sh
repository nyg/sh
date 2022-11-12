#!/usr/bin/env sh

set -eu

echo Adding brew cron job…
crontab etc/brew-cron.txt

echo Done!
