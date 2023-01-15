export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

plugins=(git autojump dirhistory copypath)

export ZSH_COMPDUMP="$ZSH/cache/zcompdump-$HOST-$ZSH_VERSION"
source "$ZSH/oh-my-zsh.sh"
