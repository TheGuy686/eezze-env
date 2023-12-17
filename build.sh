#!/bin/bash
SSH_KEY=$(cat ~/.ssh/id_ed25519 | base64 --wrap=0)
export SSH_PRIVATE_KEY=$(echo $SSH_KEY)

docker-compose -f ./docker/eezze/docker-compose.yml down 
docker-compose -f ./docker/eezze/docker-compose.yml --env-file "./docker/eezze/.env" build 
