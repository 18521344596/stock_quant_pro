#!/bin/bash

# 安装系统依赖
sudo apt update && sudo apt install -y \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    openjdk-17-jdk \
    android-sdk \
    android-sdk-platform-tools

# 设置 Android SDK 环境变量
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# 接受 Android SDK 许可
yes | sudo $ANDROID_HOME/tools/bin/sdkmanager --licenses

# 安装 Android SDK 组件
sudo $ANDROID_HOME/tools/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-33" \
    "build-tools;33.0.0"

# 配置 Flutter
flutter config --android-sdk $ANDROID_HOME
flutter precache
flutter doctor --android-licenses

# 验证安装
flutter doctor -v 