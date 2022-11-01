#!/usr/bin/env sh

OS=$(uname)

# TODO: check command exists before declaring aliases

# Utilities
alias c="clear;clear"
alias cdc="cd;c"
alias tree="tree -aCF --dirsfirst -I .git"
alias cat="bat"
alias d="du -hd1"
alias df='df -h'
alias ..="cd .."
alias p='echo -e "${PATH//:/\\n}"'
alias o='open .'
alias diff='diff --color -y --suppress-common-lines'

# SVN
alias ss="svn status"
alias sc="svn commit -m"

# Git
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias gb="git branch -a"
alias gd="git diff"
alias gds="git diff --staged"
alias gpp="git pull -p"

gh() {
    URL=$(git remote get-url origin | sed -E 's/^git@|\.git$//g' | sed 's/github.com:/github.com\//')
    open "https://$URL"
}

# Vagrant
alias vl="vagrant box list"
alias vu="vagrant up"

# Docker
alias dps="docker ps"
alias dip="docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dkk="docker kill"

# Docker compose
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcbu="dcb && dcu"

# Misc
alias notes="atom /Users/user/Documents/dev/misc/cs-notes"

# OpenSSL
# sha() {
#     echo -n "$2" | openssl dgst -sha"$1"
# }

# md5
alias md5='md5sum'

# Base64
alias b64='base64 <<< '
alias d64='base64 -D <<< '

# Metasploit
alias msf='msfconsole -q'

#
# OS Specific
if [ "$OS" = OpenBSD ]
then
    alias l="colorls -FlAGhT"
elif [ "$OS" = FreeBDS ]
then
    alias l='ls -FlAGh'
elif [ "$OS" = Linux ]
then
    alias l="LC_COLLATE=C ls -AFl --color=auto --group-directories-first --si"
elif [ "$OS" = Darwin ]
then
    alias ll="LC_COLLATE=C gls -AFl --color=auto --group-directories-first --si"
    alias l="exa -lFag --group-directories-first --time-style=long-iso"

    alias brewery="brew update && brew upgrade && brew cleanup"
    alias typora='open -a Typora'
fi
