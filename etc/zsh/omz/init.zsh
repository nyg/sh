ZSH_THEME=powerlevel10k/powerlevel10k

CASE_SENSITIVE=false
HYPHEN_INSENSITIVE=true
ENABLE_CORRECTION=false

DISABLE_AUTO_TITLE=true
COMPLETION_WAITING_DOTS=true
# DISABLE_UNTRACKED_FILES_DIRTY="true"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

plugins=(git autojump)

#export ZSH_COMPDUMP="$ZSH/cache/zcompdump-$HOST-$ZSH_VERSION"
source "$ZSH/oh-my-zsh.sh"
