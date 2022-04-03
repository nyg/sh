#!/usr/bin/env sh

sudo apt-get update        &&
sudo apt-get -y upgrade    &&
#sudo apt-get dist-upgrade  &&
sudo apt-get check         &&
sudo apt-get -f install    &&
sudo apt-get clean         &&
sudo apt-get -y autoremove
