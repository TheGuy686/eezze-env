# Docker Environment Setup

## Introduction

This git project automatically does an environment setup for the Eezze generator product.

The docker compose file will install the following:

- MySQL
- Typescript / VueJS Web Server and Node / Typescript back end Express server

This will run the following 4 containers, as specified in `docker-compose.yml` it uses the `./eezze/Dockerfile` as the base:

- Eezze Rest API (Backend)
- Eezze WebSocket API (Backend)
- Eezze Frontend (Front end)
- MySQL 5.7.12

### eezzio/mysql:5.7

This is a custom image created to enable HTTP health checks on port 80 at the base path `/`. This is a workaround until internal network addressing is implemented.

## How to use

- Must have Docker installed
- Make sure an ssh key has been created and is available in your `~/.ssh` folder. Check for the correct name of your Github SSH key, defaults to `id_ed25519`,  in the `build.sh` and `setup-docker(-local).sh` files.
- Use `./setup-docker-local.sh` to create the containers and bring them online if you're running this script from the commandline and not with `Ansible`. The local variant will ensure several directories are created outside of the home directory using elevated permissions.
  - if the `Dockerfile` changes, run this setup script again.
- After install is finished, upon auto-boot of the service you do not need to `up` the containers, otherwise use; `run.sh` to first remove the containers and then create them.
  - This will work for any `docker-compose.yml` file changes as well.
- All applications must bound to host ``0.0.0.0`` to ensure outside communications works via ``localhost``

### Make HOST_IP available in all bash sessions

For the script below, replace `wlp82s0` with the network interface name for your network.

Then paste the code in this file; `sudo nano /etc/bash.bashrc`

```bash
# Set HOST_IP environment variable
IP_ADDRESS=$(ip addr show wlp82s0 | grep -w inet | awk '{print $2}' | cut -d/ -f1)

if [ ! -z "$IP_ADDRESS" ]; then
    export HOST_IP="$IP_ADDRESS"
fi
```

## Troubleshooting

### InnoDB: Table mysql/innodb_index_stats has length mismatch

To upgrade from an earlier version of 5.7, run the following within the database container;

```bash
mysql_upgrade -u root -p
```

or from your local cli:

```bash
docker exec -it eezze-db-1 mysql_upgrade -u root -p <insert root password here>
```

### General

- If there are data issues, a general volume delete will clear all named data associated with the `docker-compose.yml` file:
  - `docker-compose down -v`
- If you need to mix a local server implementation with a docker container service;
  - `host.docker.internal` is the docker `localhost` equivalent.

### Nodemon script for Visual Entity Editor

This is what runs jespers content-server.js for the plugin:

```bash
nodemon --ignore 'plugins/visual-entity-editor/node_modules' --ext html,js,ts,css,json plugins/visual-entity-editor/content-server.js
```
On change detected, it will reload the `content-server.js`

#### Error "ENOSPC: System limit for number of file watchers reached, watch '/home/theguy/docker/web'"

This is how to fix this error. 

Get current number of file watchers:

```bash
cat /proc/sys/fs/inotify/max_user_watches
```

Increase to a higher limit:

```bash
sudo sysctl fs.inotify.max_user_watches=100000
```

Make the change permanent by added the following line to; `/etc/sysctl.conf`:

```bash
fs.inotify.max_user_watches=100000
```

Save file:

```bash
sudo sysctl -p
```

### Got permission denied while trying to connect to the Docker daemon socket

This happens because the current system user does not have access to the Docker socket, you need to add the user to the docker group:

- `sudo addgroup --system docker`
- `sudo adduser $USER docker`
- `newgrp docker`

### Permissions

It seems the actual docker home directory is the major factor for the permissions setting regardless of what has been set in the `Dockerfile`.
The second factor is the `UID` and `GID`, when they match the Host machine configuration there's no need on the host machine to re-set the ownership.

With that in mind;
1) we need a `user` in the `Dockerfile` with the Host machine matching GID and UID, 

```dockerfile
RUN addgroup --gid 1000 user
RUN adduser --disabled-password --gecos '' --uid 1000 --gid 1000 user
```

when user state is set, switch;

```dockerfile
USER user
```

2) Set the docker-data directory  in the Host machine home directory OR override the permissions to the user instead of root.

In the docker daemon.json configuration in `/etc/docker/daemon.json`, set the following and note the `data-root` setting which by default is in `var` directory:

**!Not recommended!** If you must, do it like so:

```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "5GB",
      "enabled": true
    }
  },
  "experimental": false,
  "features": {
    "buildkit": true
  },
  "data-root": "/home/user/docker-data"
}
```

3) If files inside your container stay owned by `root`, set all data directories to allow all `777`, e.g.:

```bash
chmod 777 -R ${HOME}/docker
```

#### References:
- https://jtreminio.com/blog/running-docker-containers-as-current-host-user/
- https://stackoverflow.com/questions/73499591/in-docker-with-root-error-eacces-permission-denied-open-root-config-confi/73499592#73499592
- https://techflare.blog/permission-problems-in-bind-mount-in-docker-volume/