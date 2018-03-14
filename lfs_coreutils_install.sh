#!/bin/bash
COREUTILS="coreutils-8.29.tar.xz"
echo "tar -xf ${COREUTILS}"
tar -xf ${COREUTILS}
echo "cd ${COREUTILS%.tar.xz}"
cd ${COREUTILS%.tar.xz}

# install hostname, default it is disable by default but is required
# by Perl test suite

./configure --prefix=/tools --enable-install-program=hostname

make 

# test
# make RUN_EXPENSIVE_TESTS=yes check

make install
