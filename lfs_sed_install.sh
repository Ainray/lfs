#!/bin/bash
SED="sed-4.4.tar.xz"
echo "tar -xf ${SED}"
tar -xf ${SED}
echo "cd ${SED%.tar.xz}"
cd ${SED%.tar.xz}

./configure --prefix=/tools

make

# test
# make check

make install
