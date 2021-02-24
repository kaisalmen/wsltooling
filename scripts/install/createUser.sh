#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

. ${DIR_ME}/.installUtils.sh
setUserName ${1-""}
createMainUser
modifyWslConf
