#!/bin/bash
set -e

# Define emulator AVD name and options
AVD_NAME="my_emulator"
AVD_OPTIONS="-no-snapshot -no-audio -no-window"

# Create and start the emulator
echo "Creating and starting the Android emulator..."
echo "no" | $ANDROID_HOME/tools/bin/avdmanager create avd -n "$AVD_NAME" -k "system-images;android-30;google_apis;x86_64"
emulator @$AVD_NAME $AVD_OPTIONS &

# Wait for the emulator to fully start
echo "Waiting for the emulator to start..."
$ANDROID_SDK_ROOT/emulator/emulator -avd $AVD_NAME -no-boot-anim -no-window -gpu swiftshader -no-snapshot -camera-back none -camera-front none -selinux disabled -qemu -m 2048 &

# Wait for the emulator to fully start (adjust the timeout as needed)
timeout 10m $ANDROID_SDK_ROOT/tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'
