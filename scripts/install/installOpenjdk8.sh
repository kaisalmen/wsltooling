#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))
VERSION_OPENJDK8_FILE="8u212b03"
VERSION_OPENJDK8_PATH="jdk8u212-b03"

if [[ ! -d ~/Downloads ]]; then
    mkdir ~/Downloads
fi

sudo apt remove openjdk-8-*
sudo apt autoremove
if [[ -d /usr/lib/openjdk8 ]]; then
    sudo rm -fr /usr/lib/openjdk8
fi
sudo mkdir -p /usr/lib/openjdk8

if [[ ! -e ~/Downloads/OpenJDK8U-jdk_x64_linux_hotspot_${VERSION_OPENJDK8_FILE}.tar.gz ]]; then
    curl -fSL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/${VERSION_OPENJDK8_PATH}/OpenJDK8U-jdk_x64_linux_hotspot_${VERSION_OPENJDK8_FILE}.tar.gz -o ~/Downloads/OpenJDK8U-jdk_x64_linux_hotspot_${VERSION_OPENJDK8_FILE}.tar.gz
fi
sudo tar -xzf ~/Downloads/OpenJDK8U-jdk_x64_linux_hotspot_${VERSION_OPENJDK8_FILE}.tar.gz -C /usr/lib/openjdk8
sudo chown root /usr/lib/openjdk8
sudo chgrp users /usr/lib/openjdk8

# update global path with available jvm tools
sudo cp -f ${DIR_ME}/../../config/etc/profile.d/configureJvmEnv.sh /etc/profile.d

source /etc/profile
