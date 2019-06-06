#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))
WINDOWS_USER_HOME="$(wslpath $(cmd.exe /C "echo | set /p _=%USERPROFILE%"))"
VERSION_MAVEN="3.6.1"

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


if [[ -f ${WINDOWS_USER_HOME}/.m2/settings.xml ]]; then
    cp ${WINDOWS_USER_HOME}/.m2/settings.xml ~/.m2
    sed -i "s:<localRepository>.*<:<localRepository>${WINDOWS_USER_HOME}/.m2/repository<:g" ~/.m2/settings.xml
fi

# update global path with available jvm tools
sudo cp -f ${DIR_ME}/../../config/etc/profile.d/configureJvmEnv.sh /etc/profile.d

bash /etc/profile.d/configureJvmEnv.sh
