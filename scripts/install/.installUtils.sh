#!/bin/bash

set -euo pipefail
DIR_INSTALL_UTILS=$(realpath $( dirname ${BASH_SOURCE[0]:-$0} ) )
USERNAME=""
HOMEDIR=""

modifyBashrc () {
  searchFor=${1}
  writeString=${2}
  if [[ $(cat ${HOMEDIR}/.bashrc | grep ${searchFor} | wc -l) == 0 ]]; then
    echo ${writeString} >> ${HOMEDIR}/.bashrc
    . ${HOMEDIR}/.bashrc
  else
    echo "${searchFor}: ${HOMEDIR}/.bashrc is already properly configured."
  fi
}

copyConfigureScript () {
  scriptToUse=${1}
  if [[ ! -d ${HOMEDIR}/.local/bin/env/ ]]; then
    mkdir -p ${HOMEDIR}/.local/bin/env/
  fi
  cp -f ${DIR_INSTALL_UTILS}/../config/local/${scriptToUse} ${HOMEDIR}/.local/bin/env/
}

setUserName () {
  USERNAME=${1-""}
  verifyUserName
}

verifyUserName () {
  if [[ ${USERNAME} == "" ]]; then
    echo "Please pass a user name"
    exit 1
  elif [[ ${USERNAME} == "root" ]]; then
    HOMEDIR="/root"
  else
    HOMEDIR="/home/${USERNAME}"
  fi
}

addSudoers () {
  suodersString=${1-""}
  suodersFilename=${2-""}
  if [[ ${suodersFilename} == "" ]]; then
    echo "Please provide a filename for sudoers file"
    exit 1
  fi

  temp_sudoers=$(mktemp)
  echo ${suodersString} > ${temp_sudoers}

  # only add sudoers.d additions after checking with visudo
  VISUDO_RES=$(sudo visudo -c -f ${temp_sudoers})
  # check with no error messages (s) and only mathcing (o)
  VISODU_PARSE_OK=$(echo ${VISUDO_RES} | grep -so "parsed OK" | wc -l)

  #only add if vidudo said OK
  if [[ VISODU_PARSE_OK -eq 1  ]]; then
      sudo cp ${temp_sudoers} /etc/sudoers.d/${suodersFilename}
  fi
}

modifyWslConf () {
  verifyUserName
  sudo cp ${DIR_INSTALL_UTILS}/../config/system/wsl.conf /etc/wsl.conf
  sudo echo "[user]" >> /etc/wsl.conf
  sudo echo "default=${USERNAME}" >> /etc/wsl.conf
}
