FROM ubuntu:noble

WORKDIR /root
ADD openvsp-build.sh /root

RUN ./openvsp-build.sh
RUN apt install -y ./OpenVSP/OpenVSP-3.40.1-Linux.deb

RUN useradd -ms /bin/bash -G video openvspuser
USER openvspuser
WORKDIR /home/openvspuser

CMD ["/usr/local/bin/vsp"]