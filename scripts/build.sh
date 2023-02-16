#!/bin/bash

set -ex

build-thead() {
D=$1 ; A=$2 ; shift 2
mkdir -p $D
pushd $D # && rm -rf *
cmake -GNinja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/riscv64-gcc.toolchain.cmake \
        -DRISCV_RVV_SCALABLE=OFF \
        -DCPU_BASELINE=RVV \
        -DCPU_RVV_FLAGS_ON=-march=$A \
        -DBUILD_SHARED_LIBS=OFF \
        -DWITH_OPENCL=OFF \
        ${@} \
    /opencv
ninja
}

build-thead /workspace/build-thead-10 rv64gcv1p0
# build-thead /workspace/build-thead-07 rv64gcv0p7_zfh_xthead
