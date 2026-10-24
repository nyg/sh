#!/usr/bin/env sh

set -eu

echo
echo Running apt-get update…
sudo apt-get update

echo
echo Running apt-get full-upgrade…
sudo apt-get -y full-upgrade

echo
echo Running apt-get autoremove…
sudo apt-get -y autoremove

echo
echo Running apt-get check…
sudo apt-get check

echo
echo Running apt-get clean
sudo apt-get clean

if [ -f /var/run/reboot-required ]; then
    echo
    echo Reboot required by: $(cat /var/run/reboot-required.pkgs 2>/dev/null)
fi
