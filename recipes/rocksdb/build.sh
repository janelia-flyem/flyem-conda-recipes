#!/bin/bash

if [[ $(uname) == Darwin ]]; then
    EXT=dylib
else
    EXT=so
fi

# Build shared library in release mode
make shared_lib

# Install headers
mkdir -p ${PREFIX}/include
cp -r include/rocksdb ${PREFIX}/include

# Install lib (with symlinks)
mkdir -p ${PREFIX}/lib
cp librocksdb.6.1.2.${EXT} ${PREFIX}/lib/
cd ${PREFIX}/lib/ && ln -s librocksdb.6.1.2.${EXT} librocksdb.${EXT} && cd -
cd ${PREFIX}/lib/ && ln -s librocksdb.6.1.2.${EXT} librocksdb.6.${EXT} && cd -
cd ${PREFIX}/lib/ && ln -s librocksdb.6.1.2.${EXT} librocksdb.6.1.${EXT} && cd -
