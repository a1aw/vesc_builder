#!/bin/bash
export PATH=/opt/Qt/5.15-static/bin:$PATH
export LD_LIBRARY_PATH=/opt/Qt/5.15-static/lib:$LD_LIBRARY_PATH
cd vesc_tool
if [ ! -f ./res/firmwares/res_fw.qrc ]; then
    ./build_cp_fw
fi
./build_lin_original_only
