#!/bin/bash

export JAVA_HOME=/usr/lib/openjdk8/jdk8u202-b08
export PATH=${JAVA_HOME}/bin:${PATH}

if [[ -d /usr/lib/graalvm-ce ]]; then
    export GRAALVM_HOME=/usr/lib/graalvm-ce/graalvm-ce-1.0.0-rc14
    export PATH=${GRAALVM_HOME}/bin:${PATH}
fi
