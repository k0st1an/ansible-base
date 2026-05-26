FROM debian:13-slim

LABEL maintainer="Konstantin Kruglov <kruglovk@gmail.com>"
LABEL repository="github.com/k0st1an/ansible-base"

COPY LICENSE README.md /
COPY requirements.txt .

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends \
    nano python3-minimal python3-pip openssh-client make iputils-ping

RUN apt autoremove -y && \
    apt autoclean && \
    rm -fr /var/lib/apt/lists/*

RUN pip3 install --break-system-packages -r requirements.txt && \
    rm requirements.txt

RUN mkdir ~/.ssh && chmod 0700 ~/.ssh && \
    printf "Host *\n  StrictHostKeyChecking=no" > ~/.ssh/config

RUN echo "\n\
    export EDITOR=nano\n\
    export PAGER='cat'\n\
    PS1=\"\[\$(tput bold)\$(tput setaf 2)\][ \[\$(tput setaf 7)\]\\d, \\\t \[\$(tput setaf 2)\]] \[\$(tput setaf 1)\]>\[\$(tput sgr0)\] \"\n\
    HISTCONTROL=ignoredups\n\
    alias l='ls -lh'\n\
    alias ll='ls -lah'" >> ~/.bashrc

WORKDIR /ansible
