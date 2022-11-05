#!/usr/bin/env sh
docker stop portainer
docker rm portainer
docker rmi portainer/portainer-ce:latest
docker run -d \
    -p 8000:8000 \
    -p 9000:9000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    --name=portainer \
    --restart=always \
    portainer/portainer-ce
