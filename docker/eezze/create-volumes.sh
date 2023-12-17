#!/bin/bash

# delete first to ensure new configuration gets applied
docker volume rm eezze_logs_stats eezze_logs_rest eezze_logs_ws eezze_logs_web eezze_logs_web_vee eezze_db_data eezze_codevolumeapi eezze_codevolumeweb eezze_codevolumeassets eezze_eezze_tmp

# Create the external volumes
docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/logs/stats \
  eezze_logs_stats

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/logs/rest \
  eezze_logs_rest

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/logs/ws \
  eezze_logs_ws

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/logs/web \
  eezze_logs_web

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/logs/logs_web_vee \
  eezze_logs_web_vee

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/mysql \
  eezze_db_data

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/api \
  eezze_codevolumeapi

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=${HOME}/docker/web \
  eezze_codevolumeweb

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=/var/www/eezze \
  eezze_codevolumeassets

docker volume create \
  --driver local \
  --opt o=bind \
  --opt type=none \
  --opt device=/tmp/docker-mnts/eezze \
  eezze_eezze_tmp