#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

if [[ ! -d ${HOMEDIR}/.local/openvscode-server/logs ]]; then
  mkdir -p ${HOMEDIR}/.local/openvscode-server/logs
fi

OPENVSCODE_SERVER_VERSION="v1.62.2"
curl -fSL https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-${OPENVSCODE_SERVER_VERSION}/openvscode-server-${OPENVSCODE_SERVER_VERSION}-linux-x64.tar.gz  -o ${HOMEDIR}/.local/openvscode-server/openvscode-server-linux-x64.tar.gz
tar -xzf ${HOMEDIR}/.local/openvscode-server/openvscode-server-linux-x64.tar.gz -C ${HOMEDIR}/.local/openvscode-server
mv  ${HOMEDIR}/.local/openvscode-server/openvscode-server-${OPENVSCODE_SERVER_VERSION}-linux-x64 ${HOMEDIR}/.local/openvscode-server/latest
rm ${HOMEDIR}/.local/openvscode-server/openvscode-server-linux-x64.tar.gz

copyConfigureScript "configureOpenVSCodeServer.sh"
modifyBashrc "configureOpenVSCodeServer.sh" ". ${HOMEDIR}/.local/bin/env/configureOpenVSCodeServer.sh"
