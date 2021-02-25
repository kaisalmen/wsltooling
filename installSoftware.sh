#!/bin/bash

set -euo pipefail

DIR_ME=$(realpath $(dirname $0))
. ${DIR_ME}/scripts/install/.installUtils.sh
setUserName "$(whoami)"

bash ${DIR_ME}/scripts/config/system/prepareXServer.sh ${USERNAME}

echo -e "\n\nInstalling docker & docker-compose apt"
bash ${DIR_ME}/scripts/install/installDocker.sh

echo -e "\n\nInstalling OpenJDK 11 via apt..."
bash ${DIR_ME}/scripts/install/installOpenjdk.sh

echo -e "\n\nInstalling Apache Maven manually..."
bash ${DIR_ME}/scripts/install/installMaven.sh

echo -e "\n\nInstalling node.js via n..."
bash ${DIR_ME}/scripts/install/installNodejs.sh

echo -e "\n\nInstalling deno..."
bash ${DIR_ME}/scripts/install/installDeno.sh

echo -e "\n\nInstalling Google Chrome..."
bash ${DIR_ME}/scripts/install/installChrome.sh

# clean-up
sudo apt autoremove
