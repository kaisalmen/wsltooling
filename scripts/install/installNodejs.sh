#!/bin/bash
set -euxo pipefail

VERSION_NODE="10.15.3-1nodesource1"

if [[ ! -e /etc/apt/sources.list.d/nodesource.list ]]; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
fi
sudo apt install -y nodejs=${VERSION_NODE}
