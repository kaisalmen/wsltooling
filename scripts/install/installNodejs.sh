#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

cp ~/.bashrc ~/.bashrc.bak
sudo apt install -y make
curl -L https://git.io/n-install | bash -s -- -y
mv ~/.bashrc.bak ~/.bashrc

mkdir -p ${HOME}/.local/bin/env/
cp ${DIR_ME}/../../config/local/configureN.sh ${HOME}/.local/bin/env/
. ${HOME}/.local/bin/env/configureN.sh

npm install -g typescript

tsc -version
