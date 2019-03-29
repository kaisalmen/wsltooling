#!/bin/bash

DIR_ME=$(realpath $(dirname $0))

# update system
echo -e "\n\nUpdating system first\n\n"
sudo apt update; sudo apt upgrade

# install Openjdk, all other packages are optional
echo -e "\n\nInstalling OpenJDK 8:"
bash ${DIR_ME}/scripts/install/installOpenjdk8.sh

# install version control and useful UI applications
echo -e "\n\nInstalling git, virt-manager and firefox:"
sudo apt install git virt-manager firefox

echo -e "\n\nFirefox:\nSet browser.newtab.preload to false in about:config. Otherwise firefox won't work properly!"

# add scripts to local bin directory
sudo cp ${DIR_ME}/scripts/bin/*Dbus.sh /usr/local/bin

# add proper permissions to all scripts
sudo chmod 755 /usr/local/bin/*Dbus.sh

addSudoersd() {
    # only add sudoers.d additions after checking with visudo
    VISUDO_RES=$(sudo visudo -c -f ${1})
    # check with no error messages (s) and only mathcing (o)
    VISODU_PARSE_OK=$(echo ${VISUDO_RES} | grep -so "parsed OK" | wc -l)
    #only add if vidudo said OK
    if [[ VISODU_PARSE_OK -eq 1  ]]; then
        sudo cp ${1} /etc/sudoers.d/
    fi
}
addSudoersd ${DIR_ME}/config/etc/sudoers.d/dbus
sudo cp ${DIR_ME}/config/etc/profile.d/configureXServer.sh /etc/profile.d

# Add extra configuration (mount all Windows drives to /)
sudo cp ${DIR_ME}/config/etc/wsl.conf /etc/wsl.conf

# clean-up
sudo apt autoremove

echo -e "\n\nPlease logout of WSL and re-login to apply all changes!\n\n"
