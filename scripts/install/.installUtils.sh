#!/bin/bash

set -euxo pipefail
DIR_ME=$(realpath $( dirname ${BASH_SOURCE[0]:-$0} ) )
USERNAME=""


modifyBashrc () {
  searchFor=${1}
  writeString=${2}
  if [[ $(cat ${HOME}/.bashrc | grep ${searchFor} | wc -l) == 0 ]]; then
    echo ${writeString} > ${HOME}/.bashrc
    . ${HOME}/.bashrc
  else
    echo "${HOME}/.bashrc is already properly configured."
  fi
}

copyConfigureScript () {
  scriptToUse=${1}
  if [[ ! -d ${HOME}/.local/bin/env/ ]]; then
    mkdir -p ${HOME}/.local/bin/env/
  fi
  cp ${DIR_ME}/../../config/local/${scriptToUse} ${HOME}/.local/bin/env/
}

setUserName () {
  USERNAME=${1-""}
}

verifyUserName () {
  if [[ ${USERNAME} == "" ]]; then
    echo "Please pass a user name"
    exit 1
  fi
}

createMainUser () {
  verifyUserName
  if [[ $(cat /etc/passwd | grep ${USERNAME} | wc -l) == 0 ]]; then
    useradd -m -s /bin/bash ${USERNAME}
  fi

  if [[ ! -d /home/${USERNAME}/Downloads ]]; then
      mkdir /home/${USERNAME}/Downloads
  fi

  _addSudoers "${USERNAME} ALL=(ALL) NOPASSWD:ALL" ${USERNAME}
}

_addSudoers () {
  suodersString=${1-""}
  temp_sudoers=$(mktemp)
  echo ${suodersString} > ${temp_sudoers}

  # only add sudoers.d additions after checking with visudo
  VISUDO_RES=$(sudo visudo -c -f ${temp_sudoers})
  # check with no error messages (s) and only mathcing (o)
  VISODU_PARSE_OK=$(echo ${VISUDO_RES} | grep -so "parsed OK" | wc -l)
  #only add if vidudo said OK
  if [[ VISODU_PARSE_OK -eq 1  ]]; then
      sudo cp ${temp_sudoers} /etc/sudoers.d/${USERNAME}
  fi
}

modifyWslConf () {
  verifyUserName
  sudo cp ${DIR_ME}/../../config/etc/wsl.conf /etc/wsl.conf
  sudo echo "[user]" >> /etc/wsl.conf
  sudo echo "default=${USERNAME}" >> /etc/wsl.conf
}
