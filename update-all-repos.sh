#!/bin/bash

cd ~/docker/api

git pull

cd ~/docker/web

git pull

cd ~/docker/api/plugins/eezze

git pull

cd /var/www/eezze/ansible-eezze-connection

git pull

cd /var/www/eezze/eezze-backend-boilerplate

git pull

cd /var/www/eezze/terraform-aws-eezze-connection

git pull
