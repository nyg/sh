#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing zsh…
    brew install zsh

    echo Installing MesloLGS font…
    (cd /Library/Fonts; curl --remote-name-all https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20{Regular,Bold,Italic,Bold%20Italic}.ttf)

    # Note: this will rename an existing .zshrc file to .zshrc.pre-oh-my-zsh.
    echo Installing oh-my-zsh…
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Note: this will run p10k configure to set up stuff in zshrc.
    echo Installing powerlevel10k…
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    echo Removing previous zshrc files…
    mv .zshrc* $HOME/.Trash

    echo Linking zshrc file…
    ln -s "$HOME/.$USER-sh/config/zshrc" "$HOME/.zshrc"
    ln -s "$HOME/.$USER-sh/config/profile" "$HOME/.zprofile"

elif is_os Linux && is_installed apt
then
    echo Installing zsh…
    sudo apt install -y zsh

    echo Installing MesloLGS font…
    (cd /usr/local/share/fonts; sudo curl --remote-name-all https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20{Regular,Bold,Italic,Bold%20Italic}.ttf)

    echo Installing oh-my-zsh…
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    rm .shell.pre-oh-my-zsh

    echo Installing autojump…
    git clone https://github.com/wting/autojump.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autojump
    (cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/autojump; ./install.py)


    echo Cloning powerlevel10k…
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    echo Linking zshrc file…
    rm "$HOME/.zshrc"
    ln -s "$HOME/.$USER-sh/config/zshrc" "$HOME/.zshrc"
    ln -s "$HOME/.$USER-sh/config/profile" "$HOME/.zprofile"

    rm $HOME/.zcompdump*

else
    echo Could not install zsh >&2
    exit 1
fi

echo Done!
