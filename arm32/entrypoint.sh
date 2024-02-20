#!/bin/bash

cd walrus

if [ "$COMPILE_ANYWAY" == "1" ]; then
    rm -rf out/arm/$MODE
fi

CC=arm-linux-gnueabihf-gcc
CXX=arm-linux-gnueabihf-g++

chown -R 0:0 out/arm/$MODE

cmake -H. -DCMAKE_EXE_LINKER_FLAGS="-static" -Bout/arm/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=arm -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=shell -GNinja

chown -R ${USER_ID}:${GROUP_ID} out/arm/$MODE

cd out/arm/$MODE/
ninja
