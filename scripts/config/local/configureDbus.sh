#!/bin/sh

dbus_status=$(sudo /etc/init.d/dbus status)
if [[ $dbus_status = *"is not running"* ]]; then
  sudo /etc/init.d/dbus restart
fi
