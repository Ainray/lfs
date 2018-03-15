#!/bin/bash
cd /sources
LINUX="linux-4.15.3.tar.xz"
[ ! -d ${LINUX%.tar.xz} ] && echo "tar -xf ${LINUX}" && tar -xf ${LINUX}
echo "cd ${LINUX%.tar.xz}"
cd ${LINUX%.tar.xz}
# check file are no stale
make mrproper
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include
