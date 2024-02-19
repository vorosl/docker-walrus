#!/bin/bash

cd walrus

if [ "$COMPILE_ANYWAY" == "1" ]; then
    rm -rf out/aarch64/$MODE
fi

CC=aarch64-linux-gnu-gcc
CXX=aarch64-linux-gnu-g++

cmake -H. -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON  -Bout/aarch64/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=aarch64 -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=shell -GNinja

chown -R ${USER_ID}:${GROUP_ID} out

cd out/aarch64/$MODE/
ninja -v
