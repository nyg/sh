#!/usr/bin/env sh

apt-get update     &&
apt-get upgrade    &&
apt-get check      &&
apt-get -f install &&
apt-get clean      &&
apt-get autoremove
