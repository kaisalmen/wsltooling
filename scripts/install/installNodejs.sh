#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

if [[ $(n --version | wc -l) == 0 ]]; then
  cp ~/.bashrc ~/.bashrc.bak
  sudo apt install -y make
  curl -L https://git.io/n-install | bash -s -- -y
  mv ~/.bashrc.bak ~/.bashrc
else
  echo "n $(n --version) and npm $(npm --version) are already installed."
fi

if [[ $(n --version | wc -l) == 0 ]]; then
  npm install -g typescript
  tsc -version
else
  echo "Typescript $(tsc --version) is already installed."
fi


. ${DIR_ME}/.installUtils.sh
copyConfigureScript "configureN.sh"
modifyBashrc "configureN.sh" ". ~/.local/bin/env/configureN.sh"
