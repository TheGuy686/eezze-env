#!/bin/bash

# needs to be a separate bash script to ensure root permissions in automated sessions with Ansible.
echo "Creating directories as root"

sudo mkdir -p /var/www/eezze
sudo chmod 770 -R /var/www
sudo chown 1000:1000 -R /var/www

sudo mkdir -p /tmp/docker-mnts/eezze
sudo chmod 770 -R /tmp/docker-mnts
sudo chown 1000:1000 -R /tmp/docker-mnts

echo "Finished creating directories as root"