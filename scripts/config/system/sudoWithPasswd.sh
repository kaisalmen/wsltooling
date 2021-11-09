#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

# this script is called by root an must fail if no user is provided
. ${DIR_ME}/../../install/.installUtils.sh
setUserName ${1-""}

# remove no passwd rule for user
sudo rm /etc/sudoers.d/${USERNAME}
