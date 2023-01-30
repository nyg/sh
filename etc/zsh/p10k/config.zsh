if [ "$TERMINAL_EMULATOR" = "JetBrains-JediTerm" -o "$TERM_PROGRAM" = "vscode" ]
then
    . "$HOME/.$USER-sh/etc/p10k/prompt-rainbow.zsh"
else
    . "$HOME/.$USER-sh/etc/p10k/prompt-classic.zsh"
fi
