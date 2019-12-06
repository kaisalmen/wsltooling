#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))
VERSION_DOCKER_COMPOSE="1.25.0"

sudo apt update
sudo apt install -y --no-install-recommends ca-certificates apt-transport-https software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install -y --no-install-recommends docker-ce
sudo curl -fSL "https://github.com/docker/compose/releases/download/${VERSION_DOCKER_COMPOSE}/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo cp ${DIR_ME}/../../config/etc/profile.d/configureDocker.sh /etc/profile.d
