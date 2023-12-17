#!/bin/bash

        IP_ADDRESS=$(ip addr show {{ adapter_name }} | grep -Po 'inet \K[\d.]+')

        # Update environment file
        if grep -qF "HOST_IP=" {{ environment_file }}; then
          sed -i "s/HOST_IP=.*/HOST_IP=$IP_ADDRESS/" {{ environment_file }}
        else
          echo "HOST_IP=$IP_ADDRESS" >> {{ environment_file }}
        fi

        # Update bashrc file
        if grep -qF "export HOST_IP=" {{ bashrc_file }}; then
          sed -i "s/export HOST_IP=.*/export HOST_IP=$I
