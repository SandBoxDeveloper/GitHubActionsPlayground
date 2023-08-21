## Use an official image as the base
#FROM ubuntu:20.04
#
## Set environment variables
##ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
#ENV ANDROID_SDK_ROOT /opt/android-sdk
#ENV ANDROID_HOME /opt/android-sdk
#ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/*/bin
#
## Install required packages
#RUN apt-get update && \
#    apt-get install -y wget unzip openjdk-11-jdk curl && \
#    rm -rf /var/lib/apt/lists/*
#
## Download and extract Android SDK
#RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip -O android-sdk.zip && \
#    ls -l && \
#    unzip android-sdk.zip -d $ANDROID_SDK_ROOT && \
#    ls -l $ANDROID_SDK_ROOT && \
#    rm android-sdk.zip
#
## Accept Android SDK licenses
#RUN echo $ANDROID_SDK_ROOT/cmdline-tools
#RUN ls -l $ANDROID_SDK_ROOT/cmdline-tools/bin
#RUN echo "y" | $ANDROID_SDK_ROOT/cmdline-tools/*/bin/sdkmanager --licenses
##
### Install required Android components
##RUN $ANDROID_HOME/cmdline-tools/bin/sdkmanager "system-images;android-25;google_apis;armeabi-v7a" "emulator"
#
## Set up AVD and start emulator (optional)
## RUN echo "no" | $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd \
##     --force \
##     --name my_avd \
##     --package "system-images;android-25;google_apis;armeabi-v7a" \
##     --abi google_apis/armeabi-v7a \
##     --device "Nexus 5"
#
## Set up entrypoint
#CMD ["/bin/bash"]
FROM ubuntu:bionic

# Install packages
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -qqy --no-install-recommends install \
    openjdk-14-jdk \
    curl \
    zip \
    unzip \
    git \
    locales \
  && rm -rf /var/lib/apt/lists/*

#==============================
# Android SDK ARGS
#==============================
ARG ARCH="x86_64"
ARG TARGET="google_apis_playstore"
ARG API_LEVEL="33"
ARG BUILD_TOOLS="33.0.2"
ARG ANDROID_ARCH=${ANDROID_ARCH_DEFAULT}
ARG ANDROID_API_LEVEL="android-${API_LEVEL}"
ARG ANDROID_APIS="${TARGET};${ARCH}"
ARG EMULATOR_PACKAGE="system-images;${ANDROID_API_LEVEL};${ANDROID_APIS}"
ARG PLATFORM_VERSION="platforms;${ANDROID_API_LEVEL}"
ARG BUILD_TOOL="build-tools;${BUILD_TOOLS}"
ARG ANDROID_CMD="commandlinetools-linux-6858069_latest.zip"
ARG ANDROID_SDK_PACKAGES="${EMULATOR_PACKAGE} ${PLATFORM_VERSION} ${BUILD_TOOL} platform-tools"

ENV JAVA_HOME="/usr/lib/jvm/java-14-openjdk-amd64/" \
    PATH=$PATH:$JAVA_HOME/bin

ENV ANDROID_SDK_ROOT="/usr/local/android-sdk"
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools

ENV CMDLINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip"

# Download Android SDK
RUN mkdir "$ANDROID_SDK_ROOT" .android \
    && mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools" \
    && curl -o commandlinetools.zip $CMDLINE_TOOLS_URL \
    && unzip commandlinetools.zip -d "$ANDROID_SDK_ROOT/cmdline-tools" \
    && mv "$ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools" "$ANDROID_SDK_ROOT/cmdline-tools/latest" \
    && rm commandlinetools.zip

# Accept all licenses
RUN yes | sdkmanager --licenses
RUN yes Y | sdkmanager --verbose --no_https ${ANDROID_SDK_PACKAGES}

### Install required Android components
RUN $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "system-images;android-25;google_apis;armeabi-v7a" "emulator"

#============================================
# Create required emulator
#============================================
ARG EMULATOR_NAME="nexus"
ARG EMULATOR_DEVICE="Nexus 6"
ENV EMULATOR_NAME=$EMULATOR_NAME
ENV DEVICE_NAME=$EMULATOR_DEVICE
RUN echo "no" | avdmanager --verbose create avd --force --name "${EMULATOR_NAME}" --device "${EMULATOR_DEVICE}" --package "${EMULATOR_PACKAGE}"
