#!/bin/bash
set -e
pushd images
# pushd ubuntu-noble
# docker build . -t vesc-builder-ubuntu-noble --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER})
# popd
pushd mxe
docker build . --progress=plain -t vesc-builder-mxe --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER})
popd
popd
