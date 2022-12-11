#!/usr/bin/env sh

xdg-open https://c-nergy.be/products.html > /dev/null 2>&1

# Notes:
# - script might not work via ssh, .xsessionrc will have to be created manually
# - script creates the /etc/xrdp/startwm.sh and .griffon files, .griffon seems to be just a back-up
#   same for /etc/xrdp/xrdp.ini and .griffon, modified to change the login logo
# - script is supposed to add the following line to /etc/pam.d/xrdp-sesman (first line) in order to read /etc/environment
#   session required pam_env.so readenv=1 user_readenv=0
# - use -c or --custom option to build xrdp from sources, xrdp version in Ubuntu 22 is from Sept '21.
#   after xrdp is compiled from source, version will be 0.9.80, see: https://github.com/neutrinolabs/xrdp/pull/2241

# Useful files:
# - /etc/xrdp/startwm.sh
# - /etc/pam.d/xrdp-sesman
# - /etc/xrdp/xrdp.ini
# - ~/.xsessionrc