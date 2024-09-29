FROM debian:12-slim

LABEL maintainer="Konstantin Kruglov <kruglovk@gmail.com>"
LABEL repository="github.com/k0st1an/ansible-base"

COPY LICENSE README.md /

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    nano python3-minimal python3-pip openssh-client

COPY requirements.txt .
RUN pip3 install --break-system-packages -r requirements.txt && \
    rm requirements.txt

RUN apt-get purge -y python3-pip && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    rm -fr /var/lib/apt/lists/*

RUN mkdir ~/.ssh && chmod 0700 ~/.ssh && \
    printf "Host *\n  StrictHostKeyChecking=no" > ~/.ssh/config

RUN echo "\n\
    export EDITOR=nano\m\
    export PAGER='cat'\n\
    PS1=\"\[\$(tput bold)\$(tput setaf 2)\][ \[\$(tput setaf 7)\]\\d, \\\t \[\$(tput setaf 2)\]] \[\$(tput setaf 1)\]>\[\$(tput sgr0)\] \"\n\
    HISTCONTROL=ignoredups\n\
    alias l='ls -lh'\n\
    alias ll='ls -lah'" >> ~/.bashrc

WORKDIR /ansible
