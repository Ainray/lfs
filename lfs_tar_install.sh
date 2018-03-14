#!/bin/bash
TAR="tar-1.30.tar.xz"
echo "tar -xf ${TAR}"
tar -xf ${TAR}
echo "cd ${TAR%.tar.xz}"
cd ${TAR%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
