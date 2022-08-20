#
# General

defaults write com.colliderli.iina SUEnableAutomaticChecks -bool true
defaults write com.colliderli.iina receiveBetaUpdate -bool true
defaults write com.colliderli.iina SUFeedURL -string "https://www.iina.io/appcast-beta.xml"
defaults write com.colliderli.iina playlistAutoAdd -bool false
defaults write com.colliderli.iina screenShotIncludeSubtitle -bool false
defaults write com.colliderli.iina screenshotShowPreview -bool false

#
# UI

# TODO doesn't work
# defaults write com.colliderli.iina controlBarToolbarButtons -array '(2,1,5,0,)'
defaults write com.colliderli.iina showRemainingTime -bool true

#
# Video/Audio

defaults write com.colliderli.iina audioLanguage -string 'en,eng,fr,fra,fre,ell,por,pt,el,gre'

#
# Subtitle

defaults write com.colliderli.iina subTextSize -int 40
defaults write com.colliderli.iina subLang -string 'en,eng,fr,fra,fre,ell,por,pt,el,gre'

#
# Control

defaults write com.colliderli.iina horizontalScrollAction -int 2
defaults write com.colliderli.iina videoViewAcceptsFirstMouse -bool true
