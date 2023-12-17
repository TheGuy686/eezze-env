#!/bin/bash

docker-compose down -f ./docker/eezze/docker-compose.yml
docker-compose --env-file "./docker/eezze/.env.local.ngrok" up -d -f ./docker/eezze/docker-compose.yml
