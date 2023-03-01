is_os()
{
    [ "$(uname)" = "$1" ]
}

is_installed()
{
    which "$1" >/dev/null
}

# Utilities
alias c="clear;clear"
alias cdc="cd;c"
alias tree="tree -aCF --dirsfirst -I .git"
alias d="du -hd1 | sort -h"
alias df='df -h'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias p='echo -e "${PATH//:/\\n}"'
alias diff='diff --color -y --suppress-common-lines'
alias x='exit'

# Git
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias gb="git branch -a"
alias gr="git remote -v"
alias gd="git diff"
alias gds="git diff --staged"
alias gpp="git pull -p"

# Vagrant
alias vl="vagrant box list"
alias vu="vagrant up"

# Docker
alias dps="docker ps -a"
alias dcp="docker container prune -f"
alias dip="docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dkk="docker kill"

# Docker compose
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcbu="dcb && dcu"

# Maven
alias mci="mvn clean install"
alias mcis="mvn clean install -DskipTests -Dpmd.skip -Dcheckstyle.skip -Dspotbugs.skip"
alias mbp="mvn buildplan:list -Dbuildplan.showLifecycles"
alias mep="mvn help:effective-pom -Dverbose"
alias mpu="mvn versions:display-property-updates | grep '->'"

# Carnotzet
alias mza="mvn zet:start"
alias mzo="mvn zet:stop zet:clean"

# OpenSSL
function sha() {
    # usage: sha 256 abcdef
    echo -n $2 | openssl dgst -sha$1
}

# md5
alias md5='md5sum'

# Base64
alias b64='base64 <<< '
alias d64='base64 -D <<< '

# Metasploit
alias msf='msfconsole -q'

# sshpass
sshp_pwd="$HOME/.config/sshpass/password.gpg"
if is_installed sshpass && [ -r "$sshp_pwd" ]
then
    alias ssh='sshpass -f <(gpg -dq "$sshp_pwd") ssh -o StrictHostKeyChecking=no ${@}'
    alias scp='sshpass -f <(gpg -dq "$sshp_pwd") scp -o StrictHostKeyChecking=no ${@}'
    alias ssho='/bin/ssh'
    alias scpo='/bin/scp'
fi

# pnpm
if [ ${VOLTA_FEATURE_PNPM-0} -eq 1 ]
then
    alias npm="echo Use pnpm / np instead"
    alias np="pnpm"
fi

# zsh
if [ "${SHELL#*zsh}" != "$SHELL" ]
then
    alias hist='fc -lED 1'
    alias hg='hist | grep -i'
    alias opt='set -o | sort'
    alias og='opt | grep -i'

    # directory stack
    alias d='dirs -v'
    for index ({1..9}) alias "$index"="cd +${index}"; unset index
fi

#
# OS Specific

if is_os OpenBSD
then
    alias l="colorls -FlAGhT"

elif is_os FreeBDS
then
    alias l='ls -FlAGh'

elif is_os Linux
then
    alias l="LC_COLLATE=C ls -AFl --color=auto --group-directories-first --si"

elif is_os Darwin
then
    if is_installed gls
    then
        alias ll="LC_COLLATE=C gls -AFl --color=auto --group-directories-first --si"
    fi

    if is_installed exa
    then
        alias l="exa -lFag --group-directories-first --time-style=long-iso"
    else
        alias l="ls -FAGlh"
    fi

    if is_installed bat
    then
        alias cat="bat"
    fi

    alias brewery="brew update && brew upgrade && brew cleanup"
    alias typora='open -a Typora'
    alias o='open .'

    gh() {
        URL=$(git remote get-url origin | sed -E 's/^git@|\.git$//g' | sed 's/github.com:/github.com\//')
        open "https://$URL"
    }
fi
