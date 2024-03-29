#!/bin/bash

set -ex

mkdir build
cd build

cmake_config_args=(
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_INSTALL_PREFIX=$PREFIX
)

cmake ${CMAKE_ARGS} -G "Ninja" .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --config Release --target install

if [[ $target_platform == linux-* ]]; then
    mkdir -p $PREFIX/lib/udev/rules.d/
    cp $RECIPE_DIR/81-funcube.rules $PREFIX/lib/udev/rules.d/
fi
