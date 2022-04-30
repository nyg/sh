#!/usr/bin/env sh

mkdir $HOME/.npm-global

npm config set prefix "$HOME/.npm-global"
npm config set scripts-prepend-node-path auto
