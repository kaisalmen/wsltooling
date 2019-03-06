#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))
WINDOWS_USER_HOME="$(wslpath $(cmd.exe /C "echo | set /p _=%USERPROFILE%"))"

VERSION_MAVEN="3.6.0"
sudo mkdir -p /usr/share/maven && mkdir -p ~/.m2 \
  && curl -fsSL -o ~/Downloads/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/${VERSION_MAVEN}/binaries/apache-maven-${VERSION_MAVEN}-bin.tar.gz \
  && sudo tar -xzf ~/Downloads/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f ~/Downloads/apache-maven.tar.gz \
  && sudo ln -fs /usr/share/maven/bin/mvn /usr/bin/mvn \
  && cp ${WINDOWS_USER_HOME}/.m2/settings.xml ~/.m2 \
  && sed -i "s:<localRepository>.*<:<localRepository>${WINDOWS_USER_HOME}/.m2/repository<:g" ~/.m2/settings.xml
