#!/bin/bash
#
# Translate a MAC address fetched from VirtualBox into a IP address
# and add it to the /etc/hosts file under eezze 
#

# Get a string of the form macaddress1=xxxxxxxxxxx
var1=$(VBoxManage showvminfo eezze --machinereadable |grep macaddress2)

# Asdign macaddress2 the MAC address as a value
eval $var1

# assign m the MAC address in lower case
m=$(echo ${macaddress2}|tr '[A-Z]' '[a-z]')

# This is the MAC address formatted with : and 0n translated into n
mymac=$(echo `expr ${m:0:2}`:`expr ${m:2:2}`:`expr ${m:4:2}`:`expr ${m:6:2}`:`expr ${m:8:2}`:`expr ${m:10:2}`)
echo "The MAC address of the virtual machine $1 is $mymac"

# Get known IP and MAC addresses
IFS=$'\n'; for line in $(arp -a); do 
#  echo $line
  IFS=' ' read -a array <<< $line
  ip=$(echo "${array[1]}"|tr "(" " "|tr ")" " ")

  if [ "$mymac" = "${array[3]}" ]; then
    echo "and the IP address is $ip"

     # Check if the hostname is already in /etc/hosts
    if grep -q "eezze" /etc/hosts; then
      # If it is, remove it
      sudo sed -i "/eezze/d" /etc/hosts
    fi

    # Add the new entry
    echo "$ip eezze" | sudo tee -a /etc/hosts
  fi

done
