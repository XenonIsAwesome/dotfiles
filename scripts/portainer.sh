#!/usr/bin/bash
docker run -d -p 9443:9443 -p 8000:8000 --name=portainer \
    -v /var/run/docker.sock:/var/run/docker.sock \
    portainer/portainer-ce
