#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))
VERSION_GRADLE="6.8.3"

# This script is called by any user. It shall succeed without a username parameter
. ${DIR_ME}/.installUtils.sh
setUserName ${1-"$(whoami)"}

if [[ $(which gradle | wc -l) == 0 ]]; then
	# download & unpack
	if [[ ! -e ${HOMEDIR}/Downloads/gradle-${VERSION_GRADLE}-bin.zip ]]; then
		curl -fSL https://services.gradle.org/distributions/gradle-${VERSION_GRADLE}-bin.zip -o ${HOMEDIR}/Downloads/gradle-${VERSION_GRADLE}-bin.zip
	fi
	sudo unzip -d /opt/gradle.tmp ${HOMEDIR}/Downloads/gradle-${VERSION_GRADLE}-bin.zip
	sudo mv /opt/gradle.tmp/gradle-${VERSION_GRADLE}/ /opt/gradle/
	sudo rmdir /opt/gradle.tmp
else
  echo -e "gradle is already installed:\n$(gradle --version)\n"
fi

copyConfigureScript "configureJvmEnv.sh"
modifyBashrc "configureJvmEnv.sh" ". ${HOMEDIR}/.local/bin/env/configureJvmEnv.sh"
