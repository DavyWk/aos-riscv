#!/bin/sh

set -ex

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
cd $SCRIPT_DIR

BUILDROOT_SRC=${PWD}/../../../../software/firemarshal/wlutil/br/buildroot

export PATH="$BUILDROOT_SRC/output/host/bin:${PATH}"
destdir="${PWD}/overlay"

# NOTE: For linking to work correctly with search paths provided by
# pkg-config, the buildroot external toolchain must be used, which
# ensures that the buildroot sysroot is searched instead of the original.

cd JohnTheRipper/src
./configure --host=riscv64-unknown-linux-gnu \
	--enable-pkg-config \
	--disable-native-tests \
	--disable-openmp \
	--with-systemwide
make

cd ../run
install -d "${destdir}/usr/bin" "${destdir}/usr/share/john/rules"
install -D -m 0755 -t "${destdir}/usr/bin" john
install -D -m 0644 -t "${destdir}/usr/share/john" *.chr *.conf *.lst
install -D -m 0644 -t "${destdir}/usr/share/john/rules" rules/*
