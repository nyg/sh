#!/usr/bin/env sh
sudo ifconfig gif0 destroy
sudo ifconfig gif0 create
sudo ifconfig gif0 tunnel 192.168.101.79 216.66.80.98
sudo ifconfig gif0 inet6 2001:470:25:66d::2 2001:470:25:66d::1 prefixlen 128
sudo route -n add -inet6 default 2001:470:25:66d::1
