#!/bin/bash
FIND="findutils-4.6.0.tar.gz"
echo "tar -xf ${FIND}"
tar -xf ${FIND}
echo "cd ${FIND%.tar.gz}"
cd ${FIND%.tar.gz}

./configure --prefix=/tools

make 

# test
# make check

make install
