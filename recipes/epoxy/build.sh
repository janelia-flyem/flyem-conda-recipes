#! /bin/bash
# Copyright 2017-2019 Peter Williams and collaborators.
# This file is licensed under a 3-clause BSD license; see LICENSE.txt.

[ "$NJOBS" = '<UNDEFINED>' -o -z "$NJOBS" ] && NJOBS=1
set -ex

meson_config_args=(
    -D docs=false
    -D egl=yes
    -D x11=true
    -D tests=false
)

mkdir -p ${PREFIX}/include/KHR
mkdir -p ${PREFIX}/include/EGL
cp ${RECIPE_DIR}/khronos-headers/KHR/* $PREFIX/include/KHR/
cp ${RECIPE_DIR}/khronos-headers/EGL/* $PREFIX/include/EGL/

meson builddir --prefix=$PREFIX --libdir=$PREFIX/lib
meson configure "${meson_config_args[@]}" builddir
ninja -v -C builddir
ninja -C builddir install

cd $PREFIX
find . '(' -name '*.la' -o -name '*.a' ')' -delete
