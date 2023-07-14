#!/bin/bash

set -ex

platform=$1
shift

build-clang() {
D=$1 ; shift 1
mkdir -p $D
pushd $D && rm -rf *
cmake -GNinja \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DWITH_OPENCL=OFF \
        -DCMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/riscv64-clang.toolchain.cmake \
        -DRISCV_CLANG_BUILD_ROOT=/usr/local \
        -DRISCV_GCC_INSTALL_ROOT=/opt/riscv \
        -DGNU_MACHINE=riscv64-linux-gnu \
        -DOPENCV_EXTRA_CXX_FLAGS="-fuse-ld=lld -ferror-limit=1" \
        ${@} \
    /opencv
ninja
}

build-gcc() {
D=$1 ; shift 1
mkdir -p $D
pushd $D && rm -rf *
cmake -GNinja \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DWITH_OPENCL=OFF \
        -DCMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/riscv64-gcc.toolchain.cmake \
        -DOPENCV_EXTRA_CXX_FLAGS="-fmax-errors=1" \
        ${@} \
    /opencv
ninja
}

BR=/workspace/build-${platform}

if [ "${platform}" = "xuantie" ] ; then
build-gcc ${BR}-rvv-07-dbg -DCMAKE_BUILD_TYPE=Debug -DRISCV_RVV_SCALABLE=OFF -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv0p7
build-gcc ${BR}-norvv
build-gcc ${BR}-rvv-07 -DRISCV_RVV_SCALABLE=OFF -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv0p7
# build-gcc ${BR}-rvv-10 -DRISCV_RVV_SCALABLE=OFF -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv1p0
# build-gcc ${BR}-rvv-scalable -DRISCV_RVV_SCALABLE=ON -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv1p0
fi

if [ "${platform}" = "xuantie-old" ] ; then
build-gcc ${BR}-norvv -DCMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/riscv64-071-gcc.toolchain.cmake -DCMAKE_CXX_FLAGS="-march=rv64gc" -DCMAKE_C_FLAGS="-march=rv64gc"
build-gcc ${BR}-rvv-07 -DCMAKE_TOOLCHAIN_FILE=/opencv/platforms/linux/riscv64-071-gcc.toolchain.cmake
fi

if [ "${platform}" = "ubuntu22" ] ; then
build-gcc ${BR}-norvv -DGNU_MACHINE=riscv64-linux-gnu
fi

if [ "${platform}" = "collab" ] ; then
# build-gcc ${BR}-rvv-10 -DRISCV_RVV_SCALABLE=OFF -DCPU_BASELINE_REQUIRE=RVV
build-gcc ${BR}-rvv-scalable -DRISCV_RVV_SCALABLE=ON -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv1p0
fi

if [ "${platform}" = "llvm" ] ; then
build-clang ${BR}-rvv -DRISCV_RVV_SCALABLE=OFF -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv1p0
build-clang ${BR}-rvv-scalable -DRISCV_RVV_SCALABLE=ON -DCPU_BASELINE_REQUIRE=RVV -DCPU_RVV_FLAGS_ON=-march=rv64gcv1p0
fi