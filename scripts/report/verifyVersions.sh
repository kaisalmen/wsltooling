#!/bin/bash

echo -e "docker:"
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

echo -e "\ndeno:"
deno --version

echo -e "\nApps:"
git --version
echo "virt-manager $(virt-manager --version)"
firefox --version
google-chrome --version
