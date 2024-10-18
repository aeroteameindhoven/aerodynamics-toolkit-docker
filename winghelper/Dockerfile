FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN set -eux; \
    apt update; \
    apt install -y \
        libqt5core5a libqt5gui5 libqt5network5 \
        libqt5opengl5-dev libqt5xml5 libqt5svg5-dev \
        libglx0 mesa-utils; \
    rm -rf /var/lib/apt/lists/*;

USER ubuntu
WORKDIR /home/ubuntu

# Upload and extract binary
COPY winghelper_1.7.1.tar.gz winghelper.tar.gz
RUN set -eux; \
    tar -xf winghelper.tar.gz; \
    rm libs/libOpenGL.so.0 winghelper.tar.gz;

CMD [ "/home/ubuntu/winghelper_1.7.1/runWingHelper.sh" ]
