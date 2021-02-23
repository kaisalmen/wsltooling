#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

sudo apt update
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y --no-install-recommends docker-ce

VERSION_DOCKER_COMPOSE="1.28.4"
sudo curl -fSL "https://github.com/docker/compose/releases/download/${VERSION_DOCKER_COMPOSE}/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
