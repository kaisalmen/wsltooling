#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))

if [[ ! -d ~/Downloads ]]; then
    mkdir ~/Downloads
fi

sudo apt remove openjdk-8-*
sudo apt autoremove
if [[ -d /usr/lib/openjdk8 ]]; then
    sudo rm -fr /usr/lib/openjdk8
fi

sudo mkdir -p /usr/lib/openjdk8
if [[ ! -e ~/Downloads/openjdk8.tar.gz ]]; then
    curl -fSL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u202-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u202b08.tar.gz -o ~/Downloads/openjdk8.tar.gz
fi
sudo tar -xzf ~/Downloads/openjdk8.tar.gz -C /usr/lib/openjdk8
sudo chown root /usr/lib/openjdk8
sudo chgrp users /usr/lib/openjdk8

# Add java to global path and export JAVA_HOME
sudo cp -f ${DIR_ME}/../../config/etc/profile.d/openjdk8.sh /etc/profile.d

sudo source /etc/profile
