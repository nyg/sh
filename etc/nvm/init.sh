export NVM_DIR="$HOME/.config/nvm"

if typeset -f zsh-defer > /dev/null
then
    zsh-defer . "$NVM_DIR/nvm.sh"
else
    . "$NVM_DIR/nvm.sh"
fi
