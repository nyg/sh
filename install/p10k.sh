#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

echo Installing MesloLGS fonts…
if is_os Darwin
then
    (cd /Library/Fonts; curl --remote-name-all https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20{Regular,Bold,Italic,Bold%20Italic}.ttf)
elif is_os Linux
then
    (cd /usr/local/share/fonts; sudo curl --remote-name-all https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20{Regular,Bold,Italic,Bold%20Italic}.ttf)
else
    echo Could not install MesloLGS fonts >&2
    exit 1
fi

echo Cloning powerlevel10k…
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.$USER-sh/softwares/powerlevel10k"

echo Linking zsh init file…
ln -s "$HOME/.$USER-sh/etc/zsh/p10k/init.zsh" "$HOME/.$USER-sh/etc/sh/rc.d/zsh-init.zsh"

echo Done, change terminal font to MesloLGS before running new shell!
