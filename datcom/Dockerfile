FROM ubuntu:noble

USER root
WORKDIR /root

RUN set -eux; \
    apt update; \
    apt install -y wget unzip gfortran; \
    rm -rf /var/lib/apt/lists/*;

USER ubuntu
WORKDIR /home/ubuntu

RUN set -eux; \
    wget https://www.pdas.com/packages/datcom.zip; \
    unzip datcom.zip -d datcom_files; \
    rm datcom.zip; \
    cd datcom_files; \
    unzip exlinux.zip -d $HOME/examples; \
    gfortran -std=legacy datcom.f -o $HOME/datcom;