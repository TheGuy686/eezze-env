#!/bin/bash

# Works on Ubuntu 18.04 (Bionic) or later releases.
# https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

ansible-galaxy install udondan.ssh-reconnect