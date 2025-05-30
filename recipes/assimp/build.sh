#!/bin/bash

mkdir build
cd build

BUILD_CONFIG=Release

# choose different settings for OS X and Linux
if [ `uname` = "Darwin" ]; then
    SCREEN_ARGS=(
        "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.9"
        "-DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS} -stdlib=libc++ -std=c++11"
        "-DCMAKE_OSX_ARCHITECTURES=$(uname -m)"
    )
else
    SCREEN_ARGS=(
        "-DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS} -std=c++11"
    )
fi

IFS=""
# now we can start configuring
cmake .. -G "Ninja" \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=$BUILD_CONFIG \
    -DCMAKE_PREFIX_PATH:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH:PATH="${PREFIX}/lib" \
    -DASSIMP_BUILD_ASSIMP_TOOLS:BOOL=OFF \
    -DASSIMP_BUILD_TESTS:BOOL=OFF \
    ${SCREEN_ARGS[@]}

# compile & install!
ninja install
