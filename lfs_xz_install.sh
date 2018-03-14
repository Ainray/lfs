#!/bin/bash
XZ="xz-5.2.3.tar.xz"
echo "tar -xf ${XZ}"
tar -xf ${XZ}
echo "cd ${XZ%.tar.xz}"
cd ${XZ%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
