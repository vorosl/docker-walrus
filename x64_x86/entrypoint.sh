#!/bin/bash

cd walrus

if [ "$COMPILE_ANYWAY" == '1' ]; then
    rm -rf out/$ARCH/$MODE
fi

CC=gcc
CXX=g++

chown -R 0:0 out/$ARCH/$MODE

cmake -H. -Bout/$ARCH/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=$ARCH -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=shell -GNinja

chown -R ${USER_ID}:${GROUP_ID} out/$ARCH/$MODE/

cd out/$ARCH/$MODE/
ninja
