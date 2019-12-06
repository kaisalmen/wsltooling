#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))
VERSION_GRAALVM="19.3.0"
FILE_GRAAVM=graalvm-ce-java8-linux-amd64-${VERSION_GRAALVM}.tar.gz

# remove existing & prerequisites
if [[ -d /usr/lib/graalvm-ce ]]; then
    sudo rm -fr /usr/lib/graalvm-ce
fi
sudo mkdir -p /usr/lib/graalvm-ce


# download & unpack
if [[ ! -d ~/Downloads ]]; then
    mkdir ~/Downloads
fi
if [[ ! -e ~/Downloads/${FILE_GRAAVM} ]]; then
    curl -fSL https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${VERSION_GRAALVM}/${FILE_GRAAVM} -o ~/Downloads/${FILE_GRAAVM}
fi

sudo tar -xzf ~/Downloads/${FILE_GRAAVM} -C /usr/lib/graalvm-ce
sudo chown root /usr/lib/graalvm-ce
sudo chgrp users /usr/lib/graalvm-ce


# update global path with available jvm tools
sudo cp -f ${DIR_ME}/../../config/etc/profile.d/configureJvmEnv.sh /etc/profile.d

bash /etc/profile.d/configureJvmEnv.sh
