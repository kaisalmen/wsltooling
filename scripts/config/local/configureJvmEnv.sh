#!/bin/sh

UPDATED_PATH=${PATH}

if [[ -d /opt/gradle/bin ]]; then
    UPDATED_PATH=/opt/gradle/bin:${UPDATED_PATH}
fi

if [[ -d /usr/lib/maven ]]; then
    export M2_HOME=/usr/lib/maven
    export MAVEN_HOME=/usr/lib/maven
    UPDATED_PATH=${M2_HOME}/bin:${UPDATED_PATH}
fi

if [[ -d /usr/lib/jvm/java-11-openjdk-amd64 ]]; then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    UPDATED_PATH=${JAVA_HOME}/bin:${UPDATED_PATH}
fi

export PATH=${UPDATED_PATH}
