#!/bin/bash

sudo apt update
sudo apt upgrade -y

# install git and other applications useful for the environment
sudo apt install -y git virt-manager firefox dbus-x11 x11-apps make unzip
