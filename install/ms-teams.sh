#!/usr/bin/env sh
# https://learn.microsoft.com/en-us/microsoftteams/get-clients?tabs=Linux

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    # echo Adding GPG key…
    # key=/usr/share/keyrings/microsoft-archive-keyring.gpg
    # curl -s https://packages.microsoft.com/keys/microsoft.asc \
    #     | gpg --dearmor \
    #     | sudo tee $key > /dev/null

    # echo Adding repository…
    # echo "deb [arch=amd64 signed-by=$key] https://packages.microsoft.com/repos/ms-teams stable main" \
    #     | sudo tee /etc/apt/sources.list.d/teams.list

    # echo Installing Teams…
    # sudo apt update
    # sudo apt install -y teams

    echo Fetching URL of latest Teams version…
    base_url=https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/
    deb=$(curl -s $base_url \
        | sed 's/.*href=\"\([^\"]*\).*/\1/' \
        | grep teams_.*_amd64.deb \
        | sort \
        | tail -1)

    if [ -z deb ]
    then
        echo Could not find version to download >&2
        exit 1
    fi

    echo Downloading deb package…
    wget -O /tmp/teams.deb $base_url$deb

    echo Installing deb package…
    sudo dpkg -i /tmp/teams.deb

    echo Done!
else
    echo Could not install Teams >&2
    exit 1
fi
