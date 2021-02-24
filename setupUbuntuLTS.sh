#!/bin/bash

set -euo pipefail

DIR_ME=$(realpath $(dirname $0))
. ${DIR_ME}/scripts/install/.installUtils.sh
setUserName ${USER}

exit

# TODO: Make all scripts work following the new approach (see node, maven)


echo -e "\n\nInstalling docker & docker-compose apt"
bash ${DIR_ME}/scripts/install/installDocker.sh

echo -e "\n\nInstalling OpenJDK 8 via apt..."
bash ${DIR_ME}/scripts/install/installOpenjdk8.sh

echo -e "\n\nInstalling Apache Maven manually..."
bash ${DIR_ME}/scripts/install/installMaven.sh

echo -e "\n\nInstalling node.js via n..."
bash ${DIR_ME}/scripts/install/installNodejs.sh

echo -e "\n\nInstalling deno..."
bash ${DIR_ME}/scripts/install/installDeno.sh

echo -e "\n\nInstalling Google Chrome..."
bash ${DIR_ME}/scripts/install/installChrome.sh


echo -e "\n\nFirefox:\nSet browser.newtab.preload to false in about:config. Otherwise firefox won't work properly!"


temp_sudoers=$(mktemp)
echo "$(whoami) ALL=(root) NOPASSWD: ${HOME}/.local/bin/env/configureDbus.sh" >> ${temp_sudoers}
addSudoers ${temp_sudoers} "configureDbus"


# copy all configuration scripts add set proper permissions
cp ${DIR_ME}/config/local/configureDbus.sh ${HOME}/.local/bin/env/
sudo chmod 755 /usr/local/bin/*.sh

# clean-up
sudo apt autoremove

