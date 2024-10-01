FROM ubuntu:noble

WORKDIR /root
RUN set -eux; \
    apt update; \
    apt install -y wget software-properties-common; \
    wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc; \
    add-apt-repository http://dl.openfoam.org/ubuntu; \
    apt update; \
    apt -y install openfoam12; \
    rm -rf /var/lib/apt/lists/*;

#RUN useradd -ms /bin/bash -G video openfoam
USER ubuntu
WORKDIR /home/ubuntu

RUN echo ". /opt/openfoam12/etc/bashrc" >> .bashrc

# CMD ["/usr/local/bin/vsp"]
