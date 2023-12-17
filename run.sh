#!/bin/bash
# Deprecated, in case of Vagrant this will set the HOST_IP to the default adapter; 10 series ip address. Do not use!
# export HOST_IP=$(hostname -I | awk '{print $1}')

# ensure these exist, otherwise volumes will not mount
mkdir -p /tmp/docker-mnts/eezze
chmod 770 -R /tmp/docker-mnts

docker-compose -f ./docker/eezze/docker-compose.yml down -v
docker-compose -f ./docker/eezze/docker-compose.yml --env-file "./docker/eezze/.env" up -d
