#!/bin/bash
set -e
git submodule update --init --recursive
cd vesc_fw
if [ ! -d ./tools/gcc-arm-none-eabi-7-2018-q2-update ]; then
    make arm_sdk_install
fi
cd ..
cd vesc_tool
git apply --reverse --check ../patches/vesc_tool/0001-build-cp-fw.patch || git apply ../patches/vesc_tool/0001-build-cp-fw.patch
git apply --reverse --check ../patches/vesc_tool/0002-lzokay-gcc12-support.patch || git apply ../patches/vesc_tool/0001-build-cp-fw.patch
cd ..
docker build . -t vesc_builder --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER})
docker run --rm -ti -v $(pwd):/ws vesc_builder /ws/docker_entrypoint.sh
