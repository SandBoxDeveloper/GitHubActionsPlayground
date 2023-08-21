# Use a base image with the necessary components (e.g., Java, Android SDK tools)
FROM adoptopenjdk/openjdk8:latest

# Set environment variables for Android SDK
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Install wget
RUN apt-get update && apt-get install -y wget

# Install Android SDK components
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O sdk-tools-linux.zip && \
    unzip sdk-tools-linux.zip -d /opt && \
    rm sdk-tools-linux.zip

RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-30" "emulator" "system-images;android-30;default;armeabi-v7a"

# Set up emulator environment variables
ENV ANDROID_SDK_ROOT=$ANDROID_HOME

# Create AVD and start emulator
CMD echo "no" | avdmanager create avd --force --name my_docker_avd --package "system-images;android-30;default;armeabi-v7a" --abi armeabi-v7a && \
    emulator -avd my_docker_avd -no-window
