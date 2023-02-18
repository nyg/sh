. "$HOME/.$USER-sh/softwares/powerlevel10k/powerlevel10k.zsh-theme"

if [ "$TERMINAL_EMULATOR" = "JetBrains-JediTerm" ]
then
    . "$HOME/.$USER-sh/etc/zsh/p10k/prompt-rainbow.zsh"
else
    . "$HOME/.$USER-sh/etc/zsh/p10k/prompt-lean.zsh"
fi
