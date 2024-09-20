FROM ubuntu:jammy AS build

ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN set -eux; \
    apt update; \
    apt install -y build-essential unzip \
        libqt5core5a libqt5gui5 libqt5network5 \
        libqt5opengl5-dev libqt5xml5 libqt5svg5-dev \
        libgl1-mesa-glx libgl1-mesa-dri mesa-utils; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*;

# Upload and extract source code
COPY xflr5-code-r1488-tags-v6.61-xflr5.zip xflr5.zip
RUN set -eux; \
    # Unzip source code
    unzip xflr5.zip; \
    mv xflr5-code-r1488-tags-v6.61-xflr5 xflr5; \
    rm xflr5.zip; \
    # Build xfoil
    cd /xflr5/XFoil-lib; \
    qmake; \
    make -j12; \
    make install; \
    ldconfig; \
    # Build xflr5
    cd /xflr5/xflr5v6; \
    qmake; \
    make -j12; \
    make install; \
    # Remove source code and build artifacts
    rm -rf /xflr5;

ENV QT_X11_NO_MITSHM=1 DISPLAY=:0.0

# Create a user and switch to it
RUN useradd -ms /bin/bash -G video xflr5user
USER xflr5user
WORKDIR /home/xflr5user

CMD [ "/usr/local/bin/xflr5" ]
