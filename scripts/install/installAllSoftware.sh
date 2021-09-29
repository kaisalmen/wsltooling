#!/bin/bash

set -euo pipefail

DIR_ME=$(realpath $(dirname $0))
. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

bash ${DIR_ME}/../config/system/prepareXServer.sh ${USERNAME}

echo -e "\n\nInstalling OpenVSCode Server"
bash ${DIR_ME}/installOpenVSCodeServer.sh

echo -e "\n\nInstalling docker & docker-compose apt"
bash ${DIR_ME}/installDocker.sh

echo -e "\n\nInstalling OpenJDK 11 via apt..."
bash ${DIR_ME}/installOpenjdk.sh

echo -e "\n\nInstalling Apache Maven manually..."
bash ${DIR_ME}/installMaven.sh

echo -e "\n\nInstalling Gradle manually..."
bash ${DIR_ME}/installGradle.sh

echo -e "\n\nInstalling node.js via n..."
bash ${DIR_ME}/installNodejs.sh

echo -e "\n\nInstalling rust..."
bash ${DIR_ME}/installRust.sh

echo -e "\n\nInstalling deno..."
bash ${DIR_ME}/installDeno.sh

echo -e "\n\nInstalling Google Chrome..."
bash ${DIR_ME}/installChrome.sh

# clean-up
sudo apt autoremove

bash ${DIR_ME}/../report/listVersions.sh
