#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# this script is called by root an must fail if no user is provided
. ${DIR_ME}/../../install/.installUtils.sh
setUserName ${1-""}
OS_TYPE=${2-"ubuntu"}

createMainUser () {
  verifyUserName
  if [[ $(cat /etc/passwd | grep ${USERNAME} | wc -l) == 0 ]]; then
    useradd -m -s /bin/bash ${USERNAME}
  fi

  # add to sudo group
  if [[ "${OS_TYPE}" == "ubuntu" ]]; then
    usermod -aG sudo ${USERNAME}
  fi
  if [[ "${OS_TYPE}" == "centos" ]]; then
    usermod -aG wheel ${USERNAME}
  fi

  if [[ ! -d ${HOMEDIR}/Downloads ]]; then
      mkdir ${HOMEDIR}/Downloads
      chown ${USERNAME}:${USERNAME} ${HOMEDIR}/Downloads
  fi

  # ensure no password is set
  passwd -d ${USERNAME}
}
createMainUser

modifyWslConf
