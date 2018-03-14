#!/bin/bash
TEXTINFO="texinfo-6.5.tar.xz"
echo "tar -xf ${TEXTINFO}"
tar -xf ${TEXTINFO}
echo "cd ${TEXTINFO%.tar.xz}"
cd ${TEXTINFO%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
