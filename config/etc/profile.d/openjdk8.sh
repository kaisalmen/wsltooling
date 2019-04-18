#!/bin/bash

if [[ -d /usr/lib/graalvm-ce ]]; then
    export GRAALVM_HOME=/usr/lib/graalvm-ce/graalvm-ce-1.0.0-rc15
    export PATH=${PATH}:${GRAALVM_HOME}/bin
fi

export JAVA_HOME=/usr/lib/openjdk8/jdk8u202-b08
export PATH=${PATH}:${JAVA_HOME}/bin
