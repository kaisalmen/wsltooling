#!/bin/bash

set -euo pipefail

DIR_ME=$(realpath $(dirname $0))

USERNAME=${1-""}
if [[ ${USERNAME} == "" ]]; then
  echo "Please pass a user name"
  exit 1
fi
useradd -m -s /bin/bash ${USERNAME}

addSudoers () {
  # only add sudoers.d additions after checking with visudo
  VISUDO_RES=$(sudo visudo -c -f ${1})
  # check with no error messages (s) and only mathcing (o)
  VISODU_PARSE_OK=$(echo ${VISUDO_RES} | grep -so "parsed OK" | wc -l)
  #only add if vidudo said OK
  if [[ VISODU_PARSE_OK -eq 1  ]]; then
      sudo cp ${1} /etc/sudoers.d/${2}
  fi
}
temp_sudoers=$(mktemp)
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > ${temp_sudoers}
addSudoers ${temp_sudoers} ${USERNAME}

cp ${DIR_ME}/config/etc/wsl.conf /etc/wsl.conf
echo "[user]" >> /etc/wsl.conf
echo "default=${USERNAME}" >> /etc/wsl.conf

# update system
echo -e "\n\nUpdating system first\n\n"
sudo apt update; sudo apt -y upgrade

exit


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

# install git and useful UI applications
echo -e "\n\nInstalling git, virt-manager and firefox via apt..."
sudo apt install git virt-manager firefox dbus-x11

echo -e "\n\nFirefox:\nSet browser.newtab.preload to false in about:config. Otherwise firefox won't work properly!"


temp_sudoers=$(mktemp)
echo "$(whoami) ALL=(root) NOPASSWD: ${HOME}/.local/bin/env/configureDbus.sh" >> ${temp_sudoers}
addSudoers ${temp_sudoers} "configureDbus"


# copy all configuration scripts add set proper permissions
cp ${DIR_ME}/config/local/configureDbus.sh ${HOME}/.local/bin/env/
sudo chmod 755 /usr/local/bin/*.sh


# clean-up
sudo apt autoremove

echo -e "\n\nPlease logout of WSL and re-login to apply all changes!\n\n"
