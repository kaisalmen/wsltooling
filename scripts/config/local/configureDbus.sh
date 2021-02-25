#!/bin/bash

dbus_status=$(service dbus status)
if [[ $dbus_status = *"is not running"* ]]; then
  sudo service dbus --full-restart
fi
