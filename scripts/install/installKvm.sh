#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-daemon-system-sysv libvirt-clients bridge-utils virt-manager

sudo adduser ${USERNAME} libvirt
sudo adduser ${USERNAME} kvm

copyConfigureScript "configureKvm.sh"
modifyBashrc "configureKvm.sh" ". ${HOMEDIR}/.local/bin/env/configureKvm.sh"
addSudoers "${USERNAME} ALL=(root) NOPASSWD: ${HOMEDIR}/.local/bin/env/configureKvm.sh" "${USERNAME}_configureKvm"
addSudoers "${USERNAME} ALL=(root) NOPASSWD: /etc/init.d/libvirtd" "${USERNAME}_libvirtd"
addSudoers "${USERNAME} ALL=(root) NOPASSWD: /etc/init.d/virtlogd" "${USERNAME}_virtlogd"
