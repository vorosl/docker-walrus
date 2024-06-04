#!/bin/bash

cd walrus

if [ "$COMPILE_ANYWAY" == '1' ]; then
    rm -rf out/$ARCH/$MODE
fi

CC=gcc
CXX=g++

if ["$STATIC_LINKING" == '1']; then
    LDFLAGS="-static"
fi

chown -R 0:0 out/$ARCH/$MODE

if [ "$PERF" == "1" ]; then
    cmake -DWALRUS_JITPERF=1 -H. -Bout/$ARCH/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=$ARCH -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=$OUTPUT -GNinja
else
    cmake -H. -Bout/$ARCH/$MODE/ -DCMAKE_BUILD_TYPE=$MODE -DWALRUS_ARCH=$ARCH -DWALRUS_HOST=linux -DWALRUS_MODE=$MODE -DWALRUS_OUTPUT=$OUTPUT -GNinja
fi

chown -R ${USER_ID}:${GROUP_ID} out/$ARCH/$MODE/

cd out/$ARCH/$MODE/
ninja
