#!/bin/bash
cd vesc_tool
if [ ! -f ./res/firmwares/res_fw.qrc ]; then
    ./build_cp_fw
fi
./build_lin_original_only
