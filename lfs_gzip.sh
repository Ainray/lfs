#!/bin/bash
GZIP="gzip-1.9.tar.xz"
echo "tar -xf ${GZIP}"
tar -xf ${GZIP}
echo "cd ${GZIP%.tar.xz}"
cd ${GZIP%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
