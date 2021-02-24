#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

sudo apt install -y openjdk-11-jdk

. ${DIR_ME}/.installUtils.sh
copyConfigureScript "configureJvmEnv.sh"
modifyBashrc "configureJvmEnv.sh" ". ~/.local/bin/env/configureJvmEnv.sh"
