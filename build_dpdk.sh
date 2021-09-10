#!/bin/bash

################################################################################
#
#  build_dpdk.sh
#
#             - Build DPDK and pktgen-dpdk for
#
#  Usage:     Adjust variables below before running, if necessary.
#
#  MAINTAINER:  jeder@redhat.com
#
#
################################################################################

################################################################################
#  Define Global Variables and Functions
################################################################################

BASEDIR=/root
VERSION=21.08
PACKAGE=dpdk
URL=http://fast.dpdk.org/rel/dpdk-${VERSION}.tar.xz
DPDKROOT=$BASEDIR/$PACKAGE-$VERSION
CONFIG=x86_64-native-linuxapp-gcc


# Download/Build DPDK
cd $BASEDIR
curl -LO $URL
tar xf dpdk-${VERSION}.tar.xz
cd $DPDKROOT
meson build
ninja -C build


# install

cd build && meson install  && cp meson-private/libdpdk-libs.pc meson-private/libdpdk.pc /usr/lib/x86_64-linux-gnu/pkgconfig/
