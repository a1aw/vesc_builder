FROM ubuntu:22.04

RUN cp /etc/apt/sources.list /etc/apt/sources.list~; \
    sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime
RUN apt-get update && apt-get install -y tzdata rsync tmux nano vim htop \
  tree ncdu wget curl iputils-ping cron && rm -rf /var/lib/apt/lists/

RUN apt-get update; \
    apt-get install -y build-essential git sudo zip; \
    rm -rf /var/lib/apt/lists/*;

RUN apt-get update; \
    apt-get install -y python3 qtbase5-dev qt5-qmake qtdeclarative5-dev qtquickcontrols2-5-dev \
    libqt5svg5-dev libqt5serialport5-dev qtconnectivity5-dev qtpositioning5-dev \
    libqt5gamepad5-dev qtbase5-private-dev; \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 0; \
    rm -rf /var/lib/apt/lists/*;
    
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
