#!/bin/bash
set -euxo pipefail

DIR_ME=$(realpath $(dirname $0))
sudo apt install openjdk-8-jdk

# Add java to global path and export JAVA_HOME
sudo cp ${DIR_ME}/../../config/etc/profile.d/openjdk8.sh /etc/profile.d
