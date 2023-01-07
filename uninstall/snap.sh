#!/usr/bin/env sh
# https://onlinux.systems/guides/20220524_how-to-disable-and-remove-snap-on-ubuntu-2204

set -eu

echo Disabling snap services…
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

echo Removing installed snap packages…
sudo snap remove --purge firefox
sudo snap remove --purge snap-store
sudo snap remove --purge gtk-common-themes
sudo snap remove --purge gnome-3-38-2004
sudo snap remove --purge core20
sudo snap remove --purge snapd-desktop-integration
sudo snap remove --purge bare
sudo snap remove --purge snapd

sudo snap list

read -p "All snaps removed? y/n" confirm
[ $confirm = n ] && exit

echo Removing snapd…
sudo apt autoremove -y --purge snapd

sudo rm -rf /var/cache/snapd/
rm -rf "$HOME/snap"

sudo apt-mark hold snapd

echo Installing gnome-control-center…
sudo apt install gnome-control-center

echo Done! Remove /snap/bin from /etc/environment and /etc/sudoers.
