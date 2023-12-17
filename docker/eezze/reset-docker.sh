#!/bin/bash

# Clear Docker build cache
docker builder prune --all --force

# Stop and remove all containers
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)

# Remove all images
docker image rm $(docker image ls -aq)

# Remove all networks
docker network rm $(docker network ls -q)

# Remove all volumes
docker volume rm $(docker volume ls -q)

# Prune unused data (including cache and system)
docker system prune --all --force
