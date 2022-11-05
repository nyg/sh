#!/usr/bin/env sh

set -eu

echo Adding brew cron job…
crontab config/brew-cron.txt

echo Done!
