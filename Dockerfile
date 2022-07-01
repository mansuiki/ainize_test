FROM nvcr.io/nvidia/pytorch:22.06-py3

RUN apt install build-essential cmake git libjson-c-dev libwebsockets-dev
WORKDIR /root
RUN git clone https://github.com/tsl0922/ttyd.git
WORKDIR /root/ttyd
RUN mkdir build
WORKDIR /root/ttyd/build
RUN cmake ..
RUN make && make install

USER root

## Basic Env
ENV \
    SHELL="/bin/bash" \
    HOME="/root"  \
    USER_GID=0
WORKDIR $HOME

ENV WORKSPACE_HOME="/workspace"
WORKDIR $WORKSPACE_HOME

COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]
ENTRYPOINT "/scripts/start.sh"
