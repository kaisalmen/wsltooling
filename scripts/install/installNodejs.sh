#!/bin/bash
set -euxo pipefail

VERSION_NODE="10.15.3"
WINDOWS_USER_HOME="$(wslpath $(cmd.exe /C "echo | set /p _=%USERPROFILE%"))"

if [[ ! -d ~/Downloads ]]; then
    mkdir ~/Downloads
fi

curl -fSL "https://nodejs.org/dist/v${VERSION_NODE}/node-v${VERSION_NODE}-linux-x64.tar.xz" -o ~/Downloads/nodejs.tar.gz
sudo tar -xJf ~/Downloads/nodejs.tar.gz -C /usr/local --strip-components=1 --no-same-owner
rm ~/Downloads/nodejs.tar.gz
sudo ln -fs /usr/local/bin/node /usr/local/bin/nodejs
