#!/bin/bash
GAWK="gawk-4.2.0.tar.xz"
echo "tar -xf ${GAWK}"
tar -xf ${GAWK}
echo "cd ${GAWK%.tar.xz}"
cd ${GAWK%.tar.xz}

./configure --prefix=/tools

make 

# test
# make check

make install
