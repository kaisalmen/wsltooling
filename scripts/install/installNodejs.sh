#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# this script is called by any user an shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

if [[ $(which n | wc -l) == 0 ]]; then
  sudo apt install -y make
  cp ${HOMEDIR}/.bashrc ${HOMEDIR}/.bashrc.bak  
  curl -L https://git.io/n-install | bash -s -- -y
  mv ${HOMEDIR}/.bashrc.bak ${HOMEDIR}/.bashrc
else
  echo "n $(n --version) and npm $(npm --version) are already installed."
fi

copyConfigureScript "configureN.sh"
modifyBashrc "configureN.sh" ". ${HOMEDIR}/.local/bin/env/configureN.sh"

# source the script, so the following installation can proceed
. ${HOMEDIR}/.local/bin/env/configureN.sh

if [[ $(which tsc | wc -l) == 0 ]]; then
  npm install -g typescript
  tsc -version
else
  echo "Typescript $(tsc --version) is already installed."
fi
