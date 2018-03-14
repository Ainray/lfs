#!/bin/bash
M4="m4-1.4.18.tar.xz"
echo "tar -xf ${M4}"
tar -xf ${M4}
echo "cd ${M4%.tar.xz}"
cd ${M4%.tar.xz}

./configure --prefix=/tools

make install

# test
# make check
