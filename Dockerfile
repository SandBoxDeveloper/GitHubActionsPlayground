# Use an official Ubuntu as the base image
FROM ubuntu:20.04

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Install required dependencies
RUN apt-get update && apt-get install -y wget unzip openjdk-11-jdk

# Download and extract Android SDK
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O sdk-tools-linux.zip && \
    unzip sdk-tools-linux.zip -d $ANDROID_HOME && \
    rm sdk-tools-linux.zip

# Accept Android SDK licenses
RUN yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses

# Install Android emulator components
RUN $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --install "system-images;android-25;google_apis;armeabi-v7a"

# Set up emulator environment variables
ENV ANDROID_SDK_ROOT=$ANDROID_HOME

# Set up AVD
RUN echo "no" | $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd \
    --force \
    --name my_docker_avd \
    --package "system-images;android-25;google_apis;armeabi-v7a" \
    --abi google_apis/armeabi-v7a \
    --device "Nexus 5"

# Set the entrypoint to start the emulator
CMD $ANDROID_HOME/emulator/emulator -avd my_docker_avd -no-window
