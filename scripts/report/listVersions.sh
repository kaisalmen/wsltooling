#!/bin/bash

set -euo pipefail

. ~/.local/bin/env/configureJvmEnv.sh
. ~/.local/bin/env/configureN.sh
. ~/.cargo/env
. ~/.local/bin/env/configureDeno.sh

echo -e "\n\nListing software versions:"

echo -e "\ndocker:"
docker --version
docker-compose --version

echo -e "\njava:"
java --version
javac --version
mvn --version

echo -e "\nnode:"
echo "n $(n --version)"
echo "node $(node --version)"
echo "npm $(npm --version)"
echo "tsc $(tsc --version)"

echo -e "\nrust:"
rustup --version
rustc --version
cargo --version

echo -e "\ndeno:"
deno --version

echo -e "\nApps:"
git --version
echo "virt-manager $(virt-manager --version)"
firefox --version
google-chrome --version
