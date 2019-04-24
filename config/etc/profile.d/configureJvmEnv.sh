#!/bin/bash

VERSION_GRAALVM="1.0.0-rc16"
VERSION_OPENJDK8_PATH="jdk8u212-b03"
UPDATED_PATH=${PATH}

if [[ -d /usr/lib/maven ]]; then
    export M2_HOME=/usr/lib/maven
    export MAVEN_HOME=/usr/lib/maven
    UPDATED_PATH=${M2_HOME}/bin:${UPDATED_PATH}
fi

if [[ -d /usr/lib/graalvm-ce ]]; then
    export GRAALVM_HOME=/usr/lib/graalvm-ce/graalvm-ce-${VERSION_GRAALVM}
    UPDATED_PATH=${UPDATED_PATH}:${GRAALVM_HOME}/bin
fi

if [[ -d /usr/lib/openjdk8/${VERSION_OPENJDK8_PATH} ]]; then
    export JAVA_HOME=/usr/lib/openjdk8/${VERSION_OPENJDK8_PATH}
    UPDATED_PATH=${UPDATED_PATH}:${JAVA_HOME}/bin
fi

export PATH=${UPDATED_PATH}
