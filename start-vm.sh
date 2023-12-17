#!/bin/bash

# Variables
vm_name="eezze"
username="vagrant"  # replace with the username on the guest OS
password="vagrant"  # replace with the password for the username on the guest OS
port="2000"  # Eezze web generator application port
ssh_config_path=~/.ssh/config
adapter="wlp82s0"

# Start the VM
VBoxManage startvm "$vm_name" --type headless

# Get the IP address of the primary network adapter and its subnet
# Assuming eth0 is the primary network adapter, replace if not
subnet=$(ip -o -f inet addr show | awk '/'$adapter'/ {print $4}')

# Initial command to populate ip_address
ip_address=$(nmap -p $port $subnet -oG - | awk '/open/{print $2}')

# Scan the subnet for the open port
while [[ -z $ip_address ]]; do
  echo "Waiting for port $port to be open..."
  sleep 5
  ip_address=$(nmap -p $port $subnet -oG - | awk '/open/{print $2}')
done

echo "VM has started"

# Check if the hostname is already in /etc/hosts
if grep -q "$vm_name" /etc/hosts; then
    # If it is, remove it
    sudo sed -i "/$vm_name/d" /etc/hosts
fi

# Update the hosts file
echo "$ip_address $vm_name" | sudo tee -a /etc/hosts

echo "Updated hosts file"

# Check if the "eezze" configuration exists in the SSH config file
if grep -q "Host eezze" "$ssh_config_path"; then
    # Try connecting to the "eezze" host using SSH
    if ssh -q -o "BatchMode=yes" eezze exit; then
        echo "SSH connection to 'eezze' successful."

        # nohup remmina -c ~/.local/share/remmina/group_ssh_eezze_eezze.remmina &
        # xdotool search --onlyvisible --class "konsole" windowclose

        ssh eezze "source ~/eezze-docker-env/env_variables.sh"
    else
        echo "SSH configuration for 'eezze' is incorrect. Please update your SSH config."
    fi
else
    echo "SSH configuration for 'eezze' is missing. Please configure your SSH config."
fi
