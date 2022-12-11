#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    echo Uninstalling previous versions…
    sudo apt purge docker docker-ce docker.io containerd runc
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd

    echo Installing required dependencies…
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg lsb-release

    echo Adding GPG key…
    key=/etc/apt/keyrings/docker.gpg
    curl -fsS https://download.docker.com/linux/ubuntu/gpg \
        | gpg --dearmor \
        | sudo tee $key > /dev/null

    echo Adding repository…
    echo "deb [arch=$(dpkg --print-architecture) signed-by=$key] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list

    echo Installing Docker Engine, containerd and Docker Compose…
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    echo Adding docker group…
    sudo groupadd docker || echo Group docker already exists
    sudo usermod -aG docker $USER
    newgrp docker

    echo Enabling docker.service…
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service

    echo Testing Installation…
    docker run hello-world

    echo Done!
else
    echo OS not supported, exiting… >&2
    exit 1
fi
