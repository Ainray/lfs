#!/bin/bash
LINUX="linux-4.15.3.tar.xz"
echo "tar -xf ${LINUX}"
tar -xf ${LINUX}
echo "cd ${LINUX%.tar.xz}"
cd ${LINUX%.tar.xz}
# check file are no stale
make mrproper
make INSTALL_HDR_PATH=dest headers_install
[ ! -d /tools/include ] && mkdir -v /tools/include
cp -rv dest/include/* /tools/include
