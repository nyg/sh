#!/usr/bin/env sh

apt-get update        &&
apt-get -y upgrade    &&
apt-get dist-upgrade  &&
apt-get check         &&
apt-get -f install    &&
apt-get clean         &&
apt-get -y autoremove
