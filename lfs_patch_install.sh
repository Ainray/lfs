#!/bin/bash
PATCH="patch-2.7.6.tar.xz"
echo "tar -xf ${PATCH}"
tar -xf ${PATCH}
echo "cd ${PATCH%.tar.xz}"
cd ${PATCH%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
