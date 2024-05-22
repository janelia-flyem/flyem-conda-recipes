#!/bin/bash

if [[ $(uname) == Darwin ]]; then
    EXT=dylib
else
    EXT=so
fi

# The basholeveldb source code uses std:auto_ptr, which was removed in c++17.
# We have to use an older c++ standard.
export CXXFLAGS="${CXXFLAGS} -std=c++11"

# Build
make

# Install headers
mkdir -p ${PREFIX}/include
cp -r include/leveldb ${PREFIX}/include

# Install lib (with symlinks)
mkdir -p ${PREFIX}/lib
cp libleveldb.${EXT}.1.9 ${PREFIX}/lib/
cd ${PREFIX}/lib/ && ln -s libleveldb.${EXT}.1.9 libleveldb.${EXT}.1 && cd -
cd ${PREFIX}/lib/ && ln -s libleveldb.${EXT}.1 libleveldb.${EXT} && cd -
