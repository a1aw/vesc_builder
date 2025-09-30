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
    apt-get install -y autoconf automake autopoint bash bison bzip2 flex \
    gettext git g++ gperf intltool libffi-dev libgdk-pixbuf2.0-dev libtool \
    libltdl-dev libssl-dev libxml-parser-perl make openssl p7zip-full patch \
    perl pkg-config python3 ruby scons sed unzip wget xz-utils g++-multilib \
    libc6-dev-i386 libtool-bin lzip python3-packaging python3-setuptools python3-mako; \
    rm -rf /var/lib/apt/lists/*;

RUN cd /opt; \
    mkdir mxe2; \
    git clone https://github.com/mxe/mxe.git mxe2;

RUN cd /opt/mxe2; \
    make qtbase -j$(nproc); \
    make qtserialport -j$(nproc); \
    make qtconnectivity -j$(nproc); \
    make qtquickcontrols -j$(nproc); \
    make qtquickcontrols2 -j$(nproc); \
    make qtserialbus -j$(nproc); \
    make qtlocation -j$(nproc); \
    make qtgamepad -j$(nproc); \
    make qtgraphicaleffects -j$(nproc);
    
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
