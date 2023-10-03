#!/bin/bash
set -e

# Define Android SDK tools URL and directory
SDK_URL="https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip"
SDK_DIR="$HOME/Library/Android/sdk"

# Print the value of SDK_DIR
echo "SDK_DIR is set to: $SDK_DIR"

# The desired Java version (Java 11)
JAVA_VERSION="11"

# Check if the desired Java version is already installed
if ! java -version 2>&1 | grep "openjdk version \"$JAVA_VERSION" > /dev/null; then
    echo "Java $JAVA_VERSION not found. Installing..."

    # Install required dependencies (using Homebrew)
    brew install openjdk@11

    # Set JAVA_HOME and update PATH
    export JAVA_HOME="/usr/local/opt/openjdk@11"
    export PATH="$JAVA_HOME/bin:$PATH"

    # Print the value of JAVA_VERSION
    echo "Java $JAVA_VERSION installed successfully."
fi

# Download and unzip Android SDK tools
mkdir -p "$SDK_DIR"
curl -o sdk.zip "$SDK_URL"
unzip -q sdk.zip -d "$SDK_DIR"
rm -f sdk.zip

# Set environment variables
export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"

# Accept Android licenses
yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses

# Install desired Android components
$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --install "platform-tools" "platforms;android-30" "build-tools;30.0.3" "emulator"