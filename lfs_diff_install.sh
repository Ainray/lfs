#!/bin/bash
DIFF="diffutils-3.6.tar.xz"
echo "tar -xf ${DIFF}"
tar -xf ${DIFF}
echo "cd ${DIFF%.tar.xz}"
cd ${DIFF%.tar.xz}

./configure --prefix=/tools

make 

# test
# make check

make install
