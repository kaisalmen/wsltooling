#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# this script is called by root an must fail if no user is provided
. ${DIR_ME}/../../install/.installUtils.sh
setUserName ${1-""}

# no passwd for user when sudo is invoked
addSudoers "${USERNAME} ALL=(ALL) NOPASSWD:ALL" "${USERNAME}"
