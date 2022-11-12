#!/usr/bin/env sh
echo "Europe/Paris" > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
