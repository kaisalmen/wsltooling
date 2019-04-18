#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))

if [[ ! -d ~/Downloads ]]; then
    mkdir ~/Downloads
fi

if [[ -d /usr/lib/graalvm-ce ]]; then
    sudo rm -fr /usr/lib/graalvm-ce
fi

VERSION_GRAALVM="1.0.0-rc15"
sudo mkdir -p /usr/lib/graalvm-ce
if [[ ! -e ~/Downloads/graalvm-ce.tar.gz ]]; then
    curl -fSL https://github.com/oracle/graal/releases/download/vm-${VERSION_GRAALVM}/graalvm-ce-${VERSION_GRAALVM}-linux-amd64.tar.gz -o ~/Downloads/graalvm-ce.tar.gz
fi
sudo tar -xzf ~/Downloads/graalvm-ce.tar.gz -C /usr/lib/graalvm-ce
sudo chown root /usr/lib/graalvm-ce
sudo chgrp users /usr/lib/graalvm-ce

# Add java to global path and export JAVA_HOME anf GRAALVM_HOME
sudo cp -f ${DIR_ME}/../../config/etc/profile.d/openjdk8.sh /etc/profile.d

sudo source /etc/profile
