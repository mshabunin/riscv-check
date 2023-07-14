#!/bin/bash

set -ex

# =======
# Prepare

mkdir -p workspace

# python3 -m http.server -d download

# ===
# Run

run() {
    docker run -it \
    -u $(id -u):$(id -g) \
    -v `pwd`/workspace:/workspace \
    -v `pwd`/scripts:/scripts:ro \
    -v `pwd`/../opencv:/opencv:ro \
    -v `pwd`/../opencv_extra:/opencv_extra:ro \
    -e CCACHE_DIR=/workspace/.ccache \
    -e PATH=/scripts:${PATH} \
    ${tag} \
    $@
}

# for platform in xuantie ubuntu22 llvm collab ; do
# for platform in xuantie-old ; do
for platform in xuantie ; do
# for platform in collab ; do

tag=opencv-riscv-check-${platform}
# docker build --build-arg CPUNUM=12 -t ${tag} -f Dockerfile-${platform} .
# run build.sh ${platform}
run test.sh
# run bash

done