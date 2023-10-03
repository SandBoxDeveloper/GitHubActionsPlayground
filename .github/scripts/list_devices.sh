#!/bin/bash

function list_devices() {
  adb devices -l
  devices=$(adb devices | awk 'NR>1 {print $1}')
  for device in $devices; do
    adb -s "$device" emu kill 2>/dev/null || adb -s "$device" kill-server
  done
}

list_devices