#!/bin/bash

echo Installing Ansible
echo ------------------
bash ./ansible/install.sh
echo 
echo ------------------

echo Installing Vagrant
echo ------------------
bash ./vagrant/install.sh
echo 
echo ------------------