## Core Ubuntu-based changes ##

FROM ubuntu:22.04

USER root

# Basic package update and upgrade
RUN apt-get update && apt-get upgrade -y

# Install common dev tools
RUN apt-get install -y git wget unzip glibc-source build-essential cmake apt-utils ninja-build pkg-config \
      gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf libuv1-dev

ARG DEBIAN_FRONTEND=noninteractive

COPY entrypoint.sh .

CMD ["/bin/bash", "entrypoint.sh"]
