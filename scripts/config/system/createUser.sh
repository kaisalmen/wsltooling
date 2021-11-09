#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# this script is called by root an must fail if no user is provided
. ${DIR_ME}/../../install/.installUtils.sh
setUserName ${1-""}

createMainUser () {
  verifyUserName
  if [[ $(cat /etc/passwd | grep ${USERNAME} | wc -l) == 0 ]]; then
    useradd -m -s /bin/bash ${USERNAME}
  fi
  # add to sudo group
  usermod -aG sudo ${USERNAME}

#  userhome=$(sudo -u ${USERNAME} sh -c 'echo $HOME')
  if [[ ! -d ${HOMEDIR}/Downloads ]]; then
      mkdir ${HOMEDIR}/Downloads
      chown ${USERNAME}:${USERNAME} ${HOMEDIR}/Downloads
  fi

  addSudoers "${USERNAME} ALL=(ALL) NOPASSWD:ALL" "${USERNAME}"

  # ensure no password is set
  passwd -d ${USERNAME}
}
createMainUser

modifyWslConf
