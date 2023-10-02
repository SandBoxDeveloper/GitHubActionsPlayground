#!/bin/bash
set -e

# Define Android SDK tools URL and directory
SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
SDK_DIR="$HOME/android-sdk"

# Print the value of SDK_DIR
echo "SDK_DIR is set to: $SDK_DIR"

# The desired Java version (Java 17)
JAVA_VERSION="17"

# Check if the desired Java version is already installed
if ! java -version 2>&1 | grep "openjdk version \"$JAVA_VERSION" > /dev/null; then
    echo "Java $JAVA_VERSION not found. Installing..."

    # Install required dependencies
    sudo apt-get update -q
    sudo apt-get install -qq -y openjdk-$JAVA_VERSION-jdk

    # Set JAVA_HOME and update PATH
    export JAVA_HOME="/usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64"
    # export PATH="$JAVA_HOME/bin:$PATH"
    # echo "PATH JAVA is set to: $PATH"

    # Print the value of JAVA_VERSION
    echo "Java $JAVA_VERSION installed successfully."

    # Print the value of JAVA_HOME
    #echo "Java HOME is set to: $JAVA_HOME"

    #echo "Contents of JAVA_HOME:"
    #tree "$JAVA_HOME"
fi

# Download and unzip Android SDK tools
mkdir -p "$SDK_DIR"
wget -q "$SDK_URL" -O sdk.zip
unzip -q sdk.zip -d "$SDK_DIR"
rm -f sdk.zip

# Set environment variables
export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin"
export PATH="$JAVA_HOME/bin:$PATH"

# Print the value of SDK_DIR
echo "ANDROID_SDK_ROOT is set to: $ANDROID_SDK_ROOT"
echo "PATH is set to: $PATH"

# List the contents of the ANDROID_SDK_ROOT directory
echo "Contents of ANDROID_SDK_ROOT:"
tree "$ANDROID_SDK_ROOT"

# source $HOME/.bashrc # Load environment variables

# Accept Android licenses
yes | "$ANDROID_HOME"/cmdline-tools/latest/bin/sdkmanager --licenses

# Install desired Android components
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "emulator"