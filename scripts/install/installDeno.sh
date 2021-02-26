#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

if [[ $(which deno | wc -l) == 0 ]]; then
  sudo apt install -y unzip
  cp ${HOMEDIR}/.bashrc ${HOMEDIR}/.bashrc.bak
  curl -fsSL https://deno.land/x/install/install.sh | sh
  mv ${HOMEDIR}/.bashrc.bak ${HOMEDIR}/.bashrc
else
  echo "deno $(deno --version) is already installed."
fi

copyConfigureScript "configureDeno.sh"
modifyBashrc "configureDeno.sh" ". ${HOMEDIR}/.local/bin/env/configureDeno.sh"
