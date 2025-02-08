#!/bin/bash

# Set environment variables
export BOOST_ROOT=/usr/include/boost
export OPENSSL_ROOT=/usr/include/openssl
export CURL_ROOT=/usr/include/curl

# Create build directory if it doesn't exist
mkdir -p build

# Configure CMake
cmake -B build -S . -DCMAKE_BUILD_TYPE=Debug

# Build the project
cmake --build build 