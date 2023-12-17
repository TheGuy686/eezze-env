#
# Create base Eezze image
#
FROM ubuntu:22.04 as eezze

# This will pass on the host system user and group id's, to align permissions.
# src: https://vsupalov.com/docker-shared-permissions/
#

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Install updates
RUN apt update && apt upgrade -y

# Install system dependencies
RUN \
  apt -y install openssh-client git mysql-client curl gnupg dirmngr apt-transport-https lsb-release ca-certificates software-properties-common

# Install Ansible
ARG DEBIAN_FRONTEND=noninteractive
RUN \
  add-apt-repository --yes --update ppa:ansible/ansible \
  && apt update \
  && apt -y install ansible \
  && ansible-galaxy install udondan.ssh-reconnect

# Install Node 16
RUN \
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && apt-get update && apt -y install nodejs build-essential \
  && npm install -g ts-node typescript nodemon

# Install Terraform CLI
RUN \
  curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
  && apt update && apt install terraform

# Install AWS CLI
RUN \
  apt-get install -y unzip \
  && curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install

# Clean up to reduce the image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# This does not work under windows with WSL (1 or 2), there's no ssh agent running.
#RUN \
#  --mount=type=ssh mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Add Github SSH on build
ARG SSH_PRIVATE_KEY

USER user

RUN mkdir ~/.ssh/ && echo "${SSH_PRIVATE_KEY}" | base64 --d > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# User for subsequent images, root
USER root

#
# Create project Eezze-API
#
FROM eezze as eezze-api

RUN mkdir -p /usr/www && chown -R user:user /usr/www

USER user

# Copy AWS Credentials, make sure the directory and files exist
#COPY .aws/credentials /home/user/.aws/credentials
#COPY .aws/config /home/user/.aws/config

# Git global setup
ENV GIT_AUTHOR_NAME="Eezze"
ENV GIT_AUTHOR_EMAIL="support@eezze.io"
ENV GIT_COMMITTER_NAME="Eezze"
ENV GIT_COMMITTER_EMAIL="support@eezze.io"

WORKDIR /usr/www/api

ARG BUILD_FORCE=1
RUN \
  git clone --recursive git@github.com:eezze/eezze-generator-backend-non-ts.git .
RUN \
  npm i

# Assets dir.
USER root
RUN mkdir -p /var/www && chown -R user:user /var/www

USER user

# Deployment on AWS
WORKDIR /var/www/eezze/terraform-aws-eezze-connection
ARG BUILD_FORCE=1
RUN \
  git clone git@github.com:eezze/terraform-aws-eezze-connection.git .

# Deployment on a Server
WORKDIR /var/www/eezze/ansible-eezze-connection
ARG BUILD_FORCE=1
RUN \
  git clone git@github.com:eezze/ansible-eezze-connection.git .

# Backend boilerplate + Eezze plugin
WORKDIR /var/www/eezze/eezze-backend-boilerplate
ARG BUILD_FORCE=1
RUN \
  git clone --recursive git@github.com:eezze/eezze-backend-boilerplate.git .  
RUN \
  npm i

WORKDIR /usr/www/api

#
# Create project Eezze Generator Front End
#
FROM eezze as eezze-generator

RUN mkdir -p /usr/www && chown -R user:user /usr/www

USER user
WORKDIR /usr/www/gui

ARG BUILD_FORCE=1
RUN \
  git clone git@github.com:eezze/fe-final-version.git .
RUN \
  npm i

WORKDIR /usr/www/gui/plugins/visual-entity-editor
RUN \
  git clone git@github.com:eezze/visual-entity-editor.git .
RUN \
  npm i

WORKDIR /usr/www/gui

# Remove SSH keys
# RUN rm -rf /root/.ssh/
