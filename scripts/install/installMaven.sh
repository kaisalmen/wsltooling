#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))
VERSION_MAVEN="3.6.3"

# remove existing & prerequisites
if [[ -d /usr/lib/maven ]]; then
    sudo rm -fr /usr/lib/maven
fi
# ensure old installation directories are removed as well
if [[ -d /usr/share/maven ]]; then
    sudo rm -fr /usr/share/maven
fi
sudo mkdir -p /usr/lib/maven
if [[ ! -d ~/.m2 ]]; then
    mkdir -p ~/.m2
fi


# download & unpack
if [[ ! -d ~/Downloads ]]; then
    mkdir ~/Downloads
fi
if [[ ! -e ~/Downloads/apache-maven-${VERSION_MAVEN}-bin.tar.gz ]]; then
    curl -fSL https://apache.osuosl.org/maven/maven-3/${VERSION_MAVEN}/binaries/apache-maven-${VERSION_MAVEN}-bin.tar.gz -o ~/Downloads/apache-maven-${VERSION_MAVEN}-bin.tar.gz
fi
sudo tar -xzf ~/Downloads/apache-maven-${VERSION_MAVEN}-bin.tar.gz -C /usr/lib/maven --strip-components=1

USE_WIN_M2=${1-""}
# only use windows m2 if told to do so
if [[ ${USE_WIN_M2} == "--useWinM2" ]]; then

	if [[ ! -z ${WINDOWS_USER_HOME} ]]; then

		if [[ -f ${WINDOWS_USER_HOME}/.m2/settings.xml ]]; then
			cp -f ${WINDOWS_USER_HOME}/.m2/settings.xml ~/.m2
			sed -i "s:<localRepository>.*<:<localRepository>${WINDOWS_USER_HOME}/.m2/repository<:g" ~/.m2/settings.xml
		else
			echo "<settings><localRepository>${WINDOWS_USER_HOME}/.m2/repository</localRepository></settings>" > ~/.m2/settings.xml
		fi
	fi
fi

# update global path with available jvm tools
cp ${DIR_ME}/../../config/local/configureJvmEnv.sh ${HOME}/.local/bin/env/

. ${HOME}/.local/bin/env/configureJvmEnv.sh
