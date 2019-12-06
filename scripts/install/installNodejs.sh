#!/bin/bash
set -euxo pipefail

if [[ ! -e /etc/apt/sources.list.d/nodesource.list ]]; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
fi
sudo apt install -y nodejs
