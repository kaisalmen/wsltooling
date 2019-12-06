#!/bin/bash

VERSION_GRAALVM="19.3.0"
UPDATED_PATH=${PATH}
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
GRAALVM_HOME=/usr/lib/graalvm-ce/graalvm-ce-java8-${VERSION_GRAALVM}

if [[ -d /usr/lib/maven ]]; then
    export M2_HOME=/usr/lib/maven
    export MAVEN_HOME=/usr/lib/maven
    UPDATED_PATH=${M2_HOME}/bin:${UPDATED_PATH}
fi

if [[ -d /usr/lib/graalvm-ce ]]; then
    export GRAALVM_HOME=${GRAALVM_HOME}
    export JAVA_HOME=${GRAALVM_HOME}
    UPDATED_PATH=${GRAALVM_HOME}/bin:${JAVA_HOME}/bin:${UPDATED_PATH}
else
    if [[ -d /usr/lib/jvm/java-8-openjdk-amd64/jre ]]; then
        export JAVA_HOME=${JAVA_HOME}
        UPDATED_PATH=${JAVA_HOME}/bin:${UPDATED_PATH}
    fi
fi

export PATH=${UPDATED_PATH}
