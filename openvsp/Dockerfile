FROM ubuntu:noble

WORKDIR /root
RUN set -eux; \
    apt update; \
    apt install -y ffmpeg; \
    rm -rf /var/lib/apt/lists/*;

ADD openvsp-build.sh /root

RUN ./openvsp-build.sh
RUN apt install -y ./OpenVSP/OpenVSP-3.40.1-Linux.deb

USER ubuntu
WORKDIR /home/ubuntu

CMD ["/usr/local/bin/vsp"]