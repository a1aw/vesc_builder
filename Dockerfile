FROM ubuntu:24.04

RUN cp /etc/apt/sources.list /etc/apt/sources.list~; \
    sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
RUN apt-get update && apt-get install -y tzdata rsync tmux nano vim htop \
  tree ncdu wget curl iputils-ping cron && rm -rf /var/lib/apt/lists/

RUN apt-get update; \
    apt-get install -y build-essential sudo zip perl python3 git; \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 0; \
    rm -rf /var/lib/apt/lists/*;

RUN apt-get update; \
    apt-get build-dep -y qt5-default; \
    apt-get install -y libxcb-xinerama0-dev \
        "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev \
        flex bison gperf libicu-dev libxslt-dev ruby libssl-dev \
        libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev \
        libfontconfig1-dev libcap-dev libxtst-dev libpulse-dev libudev-dev \
        libpci-dev libnss3-dev libasound2-dev libxss-dev libegl1-mesa-dev \
        gperf bison libbz2-dev libgcrypt20-dev libdrm-dev libcups2-dev \
        libatkmm-1.6-dev libasound2-dev libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev libbluetooth-dev bluetooth blueman \
        bluez libusb-dev libdbus-1-dev bluez-hcidump bluez-tools \
        libbluetooth-dev libgles2-mesa-dev; \
    rm -rf /var/lib/apt/lists/*;

RUN cd /opt; \
    git clone https://github.com/openssl/openssl.git; \
    cd openssl; \
    git checkout openssl-3.0.13;

RUN cd /opt/openssl; \
    ./config no-shared; \
    make -j16; \
    make install; \
    ldconfig;

RUN cd /opt; \
    git clone https://code.qt.io/qt/qt5.git; \
    cd qt5; \
    git checkout v5.15.13-lts-lgpl; \
    perl init-repository --module-subset=default,-qtwebkit,-qtwebkit-examples,-qtwebengine;

RUN cd /opt/qt5; \
    mkdir build; \
    cd build; \
    ../configure -prefix /opt/Qt/5.15-static/ -release -opensource -confirm-license -static \
        -no-sql-mysql -no-sql-psql -no-sql-sqlite -no-journald -qt-zlib -no-mtdev -no-gif \
        -qt-libpng -qt-libjpeg -qt-harfbuzz -qt-pcre -no-glib -no-compile-examples -no-cups \
        -no-iconv -no-tslib -dbus-linked -no-xcb-xlib -no-eglfs -no-directfb -no-linuxfb -no-kms \
        -nomake examples -nomake tests -skip qtwebsockets -skip qtwebchannel -skip qtwebengine \
        -skip qtwayland -skip qtwinextras -skip qtsensors -skip multimedia -no-libproxy -no-icu \
        -qt-freetype -skip qtimageformats -opengl es2; \
    make -j16; \
    make install;
    
ARG USER_ID=1001
ARG GROUP_ID=1001
RUN groupadd -g $GROUP_ID -o user; \
    useradd -m -u $USER_ID -g $GROUP_ID -o -s /bin/sh user; \
    echo "user:user" | chpasswd && adduser user sudo

USER root
RUN mkdir -p /ws
RUN chown -R user:user /ws

USER user
WORKDIR /ws

ENTRYPOINT [ "bash" ]
