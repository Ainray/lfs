#!/bin/bash
DEJAGNU="dejagnu-1.6.1.tar.gz"
echo "tar -xf ${DEJAGNU}"
tar -xf ${DEJAGNU}
echo "cd ${DEJAGNU%.tar.gz}"
cd ${DEJAGNU%.tar.gz}

./configure --prefix=/tools

make install

# test
# make test
