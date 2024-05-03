#!/bin/bash

cd walrus

if [ "$COMPILE_ANYWAY" == "1" ]; then
    rm -rf out/aarch64/$MODE
fi

CC=aarch64-linux-gnu-gcc
CXX=aarch64-linux-gnu-g++

chown -R 0:0 out/aarch64/$MODE
if [ "$PERF" == "1" ]; then
    cmake -DWALRUS_JITPERF=1 -H. -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -Bout/aarch64/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=aarch64 -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=$OUTPUT -GNinja
else
    cmake -H. -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -Bout/aarch64/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=aarch64 -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=$OUTPUT -GNinja
fi

chown -R ${USER_ID}:${GROUP_ID} out/aarch64/$MODE

cd out/aarch64/$MODE/
ninja -v
