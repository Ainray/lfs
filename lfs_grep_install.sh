#!/bin/bash
GREP="grep-3.1.tar.xz"
echo "tar -xf ${GREP}"
tar -xf ${GREP}
echo "cd ${GREP%.tar.xz}"
cd ${GREP%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
