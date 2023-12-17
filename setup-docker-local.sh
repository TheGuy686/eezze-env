#!/bin/bash

echo Set SSH Key into ENV

SSH_KEY=$(cat ~/.ssh/id_ed25519 | base64 --wrap=0)

export SSH_PRIVATE_KEY=$(echo $SSH_KEY)
export BUILD_FORCE=$(echo $RANDOM)

echo Setup docker home directories

docker-compose -f ./docker/eezze/docker-compose.yml down -v

mkdir ${HOME}/docker

mkdir ${HOME}/docker/mysql
mkdir ${HOME}/docker/api
mkdir ${HOME}/docker/web
mkdir ${HOME}/docker/assets

mkdir ${HOME}/docker/logs
mkdir ${HOME}/docker/logs/rest
mkdir ${HOME}/docker/logs/ws
mkdir ${HOME}/docker/logs/web
mkdir ${HOME}/docker/logs/web
mkdir ${HOME}/docker/logs/stats
mkdir ${HOME}/docker/logs/logs_web_vee

# Create directories as root user
bash "./docker/eezze/createDirectoriesAsRoot.sh"

# Create the docker volumes
bash "./docker/eezze/create-volumes.sh"

docker-compose -f ./docker/eezze/docker-compose.yml --env-file "./docker/eezze/.env" up -d --build
