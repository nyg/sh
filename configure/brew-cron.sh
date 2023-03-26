#!/usr/bin/env sh

set -eu

echo Adding brew cron job…
crontab "$HOME"/".$USER-sh"/etc/brew/cron.txt

echo Done!
