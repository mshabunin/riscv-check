#!/bin/bash

set -ex

test-thead() {
D=$1 ; C=$2 ; shift 2
pushd ${D}
OPENCV_TEST_DATA_PATH=/opencv_extra/testdata \
python3 /opencv/modules/ts/misc/run.py \
    --qemu="qemu-riscv64 -cpu ${C} -L /usr/local/sysroot" \
    ${@} \
    .
popd
}

test-thead /workspace/build-thead-10 c908v -a
# test-thead /workspace/build-thead-07 c906fdv -a
