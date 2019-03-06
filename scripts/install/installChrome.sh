#!/usr/bin/env bash

sudo apt update && sudo apt upgrade
sudo apt install mesa-utils fonts-liberation
sudo apt purge pulseaudio libpulse0 && sudo apt autoremove

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
rm /tmp/google-chrome-stable_current_amd64.deb
