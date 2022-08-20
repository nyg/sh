#!/usr/bin/env sh

set -exu

defaults write "com.apple.finder" "FXEnableExtensionChangeWarning" -bool "false"
defaults write "NSGlobalDomain" "NSDocumentSaveNewDocumentsToCloud" -bool "false"
defaults write "com.apple.TextEdit" "RichText" -bool "false"
defaults write "com.apple.LaunchServices" "LSQuarantine" -bool "false"
defaults write "NSGlobalDomain" "ApplePressAndHoldEnabled" -bool "false"
