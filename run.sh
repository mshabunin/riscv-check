#!/bin/bash

set -ex

mkdir -p workspace

tag=opencv-riscv-thead-check
docker build --build-arg CPUNUM=12 -t ${tag} -f Dockerfile-xuantie .

docker run -it \
    -u $(id -u):$(id -g) \
    -v `pwd`/workspace:/workspace \
    -v `pwd`/scripts:/scripts:ro \
    -v `pwd`/../opencv:/opencv:ro \
    -v `pwd`/../opencv_extra:/opencv_extra:ro \
    -e CCACHE_DIR=/workspace/.ccache \
    ${tag}
