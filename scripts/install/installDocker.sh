#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

sudo apt update
sudo apt remove docker docker.io containerd runc
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y --no-install-recommends docker-ce

VERSION_DOCKER_COMPOSE="2.0.0"
if [[ ! -d ~/.docker/cli-plugins ]]; then
  mkdir -p ~/.docker/cli-plugins
fi
curl -fSL https://github.com/docker/compose/releases/download/v2.0.0/docker-compose-linux-amd64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
