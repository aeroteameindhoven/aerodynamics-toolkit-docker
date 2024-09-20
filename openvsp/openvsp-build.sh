#!/bin/bash
#
# This script builds OpenVSP on a Debian-based system
# It provides the user with options to create a zip or deb package
#
# Usage: bash openvsp-build.sh

(
    set -e

    # Set some variables
    VSPRepo=https://github.com/OpenVSP/OpenVSP.git
    OpenVSPdir=$(pwd)/OpenVSP
    NumOfThreads=$(nproc)  # Build will work with more threads. Foolproof option chosen.

    # Install packages using apt
    echo
    echo "Installing required packages using apt ..."
    apt update
    apt install -y python3-dev git git-gui cmake libxml2-dev \
    libfltk1.3-dev g++ libjpeg-dev libglm-dev libcminpack-dev \
    libglew-dev swig doxygen graphviz texlive-latex-base file desktop-file-utils

    # Create temporary directories if not present
    echo
    echo "Creating temporary directories ..."
    mkdir -p $OpenVSPdir
    mkdir -p $OpenVSPdir/build $OpenVSPdir/buildlibs

    # Download source into temporary repo directory if absent
    echo
    echo "Downloading OpenVSP source from GitHub ..."
    [ -d $OpenVSPdir/repo ] || git clone --depth=1 $VSPRepo $OpenVSPdir/repo
    cd $OpenVSPdir/repo; git pull $VSPRepo

    # Build using Make
    echo
    echo "Building libraries ..."
    rm -rf $OpenVSPdir/buildlibs/*
    echo "Build using Make" &&
    cd $OpenVSPdir/buildlibs &&
    cmake \
    -DVSP_USE_SYSTEM_LIBXML2=true \
    -DVSP_USE_SYSTEM_FLTK=false \
    -DVSP_USE_SYSTEM_GLM=false \
    -DVSP_USE_SYSTEM_GLEW=true \
    -DVSP_USE_SYSTEM_CMINPACK=true \
    -DVSP_USE_SYSTEM_LIBIGES=false \
    -DVSP_USE_SYSTEM_EIGEN=false \
    -DVSP_USE_SYSTEM_CODEELI=false \
    -DVSP_USE_SYSTEM_CPPTEST=false \
    $OpenVSPdir/repo/Libraries -DCMAKE_BUILD_TYPE=Release &&
    make -j $NumOfThreads

    # Build source
    echo
    echo "Building source ..."
    rm -rf $OpenVSPdir/build/*
    # Build using Make
    echo "Build using Make" &&
    cd $OpenVSPdir/build &&
    cmake ../repo/src/ \
    -DVSP_LIBRARY_PATH=$OpenVSPdir/buildlibs \
    -DCMAKE_BUILD_TYPE=Release \
    -DVSP_CPACK_GEN=DEB &&
    make -j $NumOfThreads package &&
    cp *.deb $OpenVSPdir/

    echo
    echo "Removing temporary directories ..."
    rm -rf $OpenVSPdir/build* $OpenVSPdir/repo

    echo
    echo "OpenVSP build successful!"
    echo "Deb package created in directory: $OpenVSPdir/"
) 2>&1 | tee openvsp-build.log
