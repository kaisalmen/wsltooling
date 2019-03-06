#!/bin/bash
set -euxo pipefail

VERSION_NODE="10.15.3"
VERSION_NPM="6.4.1"
WINDOWS_USER_HOME="$(wslpath $(cmd.exe /C "echo | set /p _=%USERPROFILE%"))"

curl -fsSL -o ~/Downloads/nodejs.tar.gz "https://nodejs.org/dist/v${VERSION_NODE}/node-v${VERSION_NODE}-linux-x64.tar.xz" \
  && sudo rm -frz -C /usr/local --strip-components=1 --no-same-owner \
  && sudo tar -xJf ~/Downloads/nodejs.tar.gz -C /usr/local --strip-components=1 --no-same-owner \
  && rm ~/Downloads/nodejs.tar.gz \
  && sudo ln -fs /usr/local/bin/node /usr/local/bin/nodejs
