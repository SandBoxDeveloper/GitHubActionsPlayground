#!/bin/bash
set -e

# Define Android SDK tools URL and directory
SDK_URL="https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip"
SDK_DIR="$HOME/android-sdk"

# Print the value of SDK_DIR
echo "SDK_DIR is set to: $SDK_DIR"

# The desired Java version (Java 17)
JAVA_VERSION="17"

# Install required dependencies
sudo apt-get update
sudo apt-get install -y openjdk-$JAVA_VERSION-jdk unzip

# Download and unzip Android SDK tools
mkdir -p "$SDK_DIR"
wget -q "$SDK_URL" -O sdk.zip
unzip -q sdk.zip -d "$SDK_DIR"
rm -f sdk.zip

# Set environment variables
export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin"

# Print the value of SDK_DIR
echo "ANDROID_SDK_ROOT is set to: $ANDROID_SDK_ROOT"
echo "PATH is set to: $PATH"

# List the contents of the ANDROID_SDK_ROOT directory
echo "Contents of ANDROID_SDK_ROOT:"
tree "$ANDROID_SDK_ROOT"

# source $HOME/.bashrc # Load environment variables

# Accept Android licenses
yes | sdkmanager --licenses

# Install desired Android components
sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "emulator"