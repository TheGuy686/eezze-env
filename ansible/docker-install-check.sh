#!/bin/bash

CURRENT_PROJECT=${PWD}

ansible-playbook -i "$CURRENT_PROJECT/inventory.ini" -vvv --check --ask-become-pass --ask-pass "$CURRENT_PROJECT/playbooks/docker-install/playbook.yml"
