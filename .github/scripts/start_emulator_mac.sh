#!/bin/bash
set -e

# Define emulator AVD name and options
AVD_NAME="my_emulator"
AVD_OPTIONS="-no-snapshot -no-audio -no-window"

# Create and start the emulator
echo "Creating and starting the Android emulator..."

# Install the required system image
$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --install "system-images;android-30;google_apis;x86_64"

# Create the AVD
echo "no" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager create avd --name "$AVD_NAME" --package "system-images;android-30;google_apis;x86_64" --abi google_apis/x86_64

# Start the emulator in the background
$ANDROID_SDK_ROOT/emulator -avd $AVD_NAME $AVD_OPTIONS &

# Wait for the emulator to fully start
echo "Waiting for the emulator to start..."

# You can adjust the timeout as needed (e.g., change 'timeout 10m' to 'timeout 5m' for a 5-minute timeout)
timeout 10m $ANDROID_SDK_ROOT/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'
