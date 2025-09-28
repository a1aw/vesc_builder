#!/bin/bash
set -e
docker build . -t vesc_builder --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER})
