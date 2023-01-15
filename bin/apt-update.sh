#!/usr/bin/env sh

set -eu

echo
echo Running apt-get update…
sudo apt-get update

echo
echo Running apt-get upgrade…
sudo apt-get -y upgrade
# sudo apt-get -y dist-upgrade

echo
echo Running apt-get autoremove…
sudo apt-get -y autoremove

echo
echo Running apt-get check…
sudo apt-get check

echo
echo Running apt-get clean
sudo apt-get clean
