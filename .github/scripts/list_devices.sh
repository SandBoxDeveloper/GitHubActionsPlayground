#!/bin/bash

function list_devices() {
  # Check for connected devices and emulators
  devices=$(adb devices | awk 'NR>1 {print $1}')

  # Check if there are devices
  if [ -n "$devices" ]; then
    echo "There are devices"

    # Loop through the list and kill each device
    for device in $devices; do
      adb -s "$device" emu kill 2>/dev/null || adb -s "$device" kill-server
    done
  else
    echo "No devices found"
  fi
}

list_devices