#!/bin/bash

mkdir -p build
cd build

CMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -std=c++11"

if [[ $(uname) == "Darwin" ]]; then
    CMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -stdlib=libc++"
fi

cmake .. \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
    -DCMAKE_PREFIX_PATH:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH:PATH="${PREFIX}/lib" \
    -DENABLE_DECODER_ATTRIBUTE_DEDUPLICATION=ON \
##

make -j ${CPU_COUNT}
make install
