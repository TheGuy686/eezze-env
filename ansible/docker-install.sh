#!/bin/bash
# export HOST_IP=$(hostname -I | awk '{print $1}')

CURRENT_PROJECT=${PWD}

# echo "$HOST_IP" > "$CURRENT_PROJECT/inventory.ini"

ansible-playbook -i "$CURRENT_PROJECT/inventory.ini" -vvv --ask-become-pass --ask-pass "$CURRENT_PROJECT/playbooks/docker-install/playbook.yml"

