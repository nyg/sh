#!/usr/bin/env sh

URL=http://mirror.switch.ch/ftp/pub/OpenBSD
#URL=http://ftp.cc.uoc.gr/mirrors/OpenBSD

cd /tmp
ftp $URL/$(uname -r)/ports.tar.gz
ftp $URL/$(uname -r)/SHA256.sig
signify -Cp /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub -x SHA256.sig ports.tar.gz

cd /usr
tar xzf /tmp/ports.tar.gz
