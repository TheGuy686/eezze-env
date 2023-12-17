# Vagrant

This will automatically install a VirtualBox VM and execute the ansible configuration located in the `../ansible` directory.

When the setup is finished, you will have a complete VM with the Eezze Generator environment.

## How to install

- Optional; if `./install-dependencies.sh` was **not** run from the root directory:
  - Run `./install.sh` to install vagrant and dependencies.
- Check the `config.yml` to make sure the network device name is correct in `network`.
  - To check, run `ifconfig`, on the left hand side the network device name needs to correspond with the network setting in the config.yml.
- Run `vagrant up eezze` to create the Eezze Generator VM and autorun the **ansible** configuration.
- After the setup, the script; `./set-hosts-file.sh` will run to set the guest machine ip to the name; `eezze`. In the browser you can access all the containers via `http://eezze:[port]`.
  - Due to the bridged network using DHCP, IP's will rotate and you will have to manually trigger this script to update your hosts file. The VM must be running for this work!
- If there are issues; you can restart with `vagrant provision eezze`.

## How to run additional Eezze Project machine

- Run `vagrant up eezzeProject`, this will create a clean Ubuntu machine that is ready to have an Eezze project installed.
- Configure the Eezze Connection with the following details;
    - user: `vagrant`
    - password: `vagrant`
    - ssh key is found in; `./.vagrant/machines/eezzeProject/virtualbox/private_key`

## How to user Vagrant as a VM installer

- In the `Vagrantfile` comment out the ansible directive on lines 24-26.
- `vagrant up`
- Once installation is done, connect via ssh: `ssh vagrant@192.168.1.37 -i .\.vagrant\machines\default\virtualbox\private_key`, where the ip address is the matching IP address of the VM machine.

