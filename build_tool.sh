#!/bin/bash
cd vesc_tool
git apply --reverse --check ../patches/vesc_tool/0001-build-cp-fw.patch && git apply ../patches/vesc_tool/0001-build-cp-fw.patch
cd ..
docker build . -t vesc_builder --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER})
docker run --rm -v $(pwd):/ws vesc_builder /ws/docker_entrypoint.sh
