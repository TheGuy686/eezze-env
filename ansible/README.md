# Ansible setup instructions

## Introduction

> If using Vagrant, there's no need to setup anything in Ansible.

This ansible script uses an IP address set in `inventory.ini` and a `user` name set in the `playbooks/group_vars/all` to connect with the remote machine and automate the installation of an Ubuntu 22.04 based installation.

> In some cases, the last step of the process can report as `failed`, if it does, run the VM and cd to `./eezze-docker-env` and execute `./run.sh` to make sure all containers are running.

## How to install

> Make sure to run the `./install.sh` to install Ansible and its dependencies, or use `./install-dependencies.sh` in the root directory.

if run from;
1) **Manual VM setup**, it relies on username / password to connect to the remote machine (or VM). For details, see the next [chapter](#vm-manual-setup), or if you have a remote machine setup; ensure the configuration details of the IP and the SSH is connectable through user/password.
2) **Vagrant automated setup**, vagrant autocreates the `vagrant` user name and connects automatically with an RSA based key to the VirtualBox VM. See more [here](../vagrant/README.md).

## VM Manual Setup

1) Download Ubuntu Server 22.04 LTS
2) Install Oracle VM VirtualBox
3) Create Linux, 64Bit host with **5Gb memory**, **20Gb hard disk**.
4) Ensure in Network Adapter configuration the following is set for Adapter 1;
   1) `Attached to: Bridged Adapter`, in the `Name` part select the correct Host machine network adapter name(!)
   2) Advanced: Promiscuous Mode: `Allow All`
   3) Restart the VM, in some cases you may need to restart the Host machine(!)
5) Install Ubuntu Server with all defaults, except:
   1) During disk setup, choose `custom`, and setup one filesystem that **covers the entire 20GB(!)**.
      1) select `/`, size: `19.998`; choose `ext4` and mount point `/`.
   2) During the **network setup** portion you should be able to see the allocated IP address which resides on the same LAN. E.g. `192.168.1.37`.
   3) During **user configuration** data setup; use `eezze` for all input fields.
   4) Make sure to check `Install OpenSSH server`.
6) Installation completed? Optional installation / settings:
   1) You can install net-tools to verify the assigned IP address:
      1) `sudo apt install net-tools`
      2) Run: `ifconfig` to check the IP address is in the same network subnet as the host machine for this adapter. E.g. ``Host: 196.28.0.1`` and ``VM: 192.28.0.3``.
   2) If SSH with user/pass doesn't work; configure proper SSH accessibility:
      1) `sudo nano /etc/ssh/sshd_config` and ensure `PasswordAuthentication` is set to `yes`.
      2) Restart the SSH service on the Ubuntu Server using the command `sudo service ssh restart` to apply the configuration changes.
      
### Host: Troubleshooting

1) Run `ansible <ip> -m ping -vvv --ask-pass` where the `<ip>` is the VM Server IP.
   1) If it fails with; `"msg": "to use the 'ssh' connection type with passwords, you must install the sshpass program"`, install `sudo apt install sshpass` on the Host machine.
2) If it can't connect, ensure in the `ansible.cfg` the following is defined:

```ini
transport = ssh
ssh_args = -o PreferredAuthentications=password -o PasswordAuthentication=yes
```
3) If you get an error for **Remote Host Identification Change**:
   1) Remove the ip from known_hosts, e.g.: `ssh-keygen -f "/home/rolfstreefkerk/.ssh/known_hosts" -R "192.168.1.39"`

4) AWS configuration has been added, I don't have it setup:

Anything AWS related such as Terraform based API's will require a valid API key and access key set in `~/.aws/credentials` file. The part must be labelled as `multithreadlabs` because only this is imported into the VM.

```bash
[multithreadlabs]
aws_access_key_id=AK....
aws_secret_access_key=5y...

```

Make sure you have this setup on the host machine, if it's not there the install will still proceed but be aware of the limitations.