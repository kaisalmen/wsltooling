#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# this script is called by any user an shall succeed without a username parameter
. ${DIR_ME}/../../install/.installUtils.sh
setUserName ${1-"$(whoami)"}

copyConfigureScript "configureDbus.sh"
modifyBashrc "configureDbus.sh" ". ${HOMEDIR}/.local/bin/env/configureDbus.sh"
addSudoers "${USERNAME} ALL=(root) NOPASSWD: ${HOMEDIR}/.local/bin/env/configureDbus.sh" "${USERNAME}_configureDbus"
addSudoers "${USERNAME} ALL=(root) NOPASSWD: /etc/init.d/dbus" "${USERNAME}_initDbus"

if [[ "${WINDOWS_10-"false"}" == "true" ]]; then
  copyConfigureScript "configureXServer.sh"
  modifyBashrc "configureXServer.sh" ". ${HOMEDIR}/.local/bin/env/configureXServer.sh"
fi
