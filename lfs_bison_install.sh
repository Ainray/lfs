#!/bin/bash
BISON="bison-3.0.4.tar.xz"
echo "tar -xf ${BISON}"
tar -xf ${BISON}
echo "cd ${BISON%.tar.xz}"
cd ${BISON%.tar.xz}

./configure --prefix=/tools 
     

make 
# test
# make check
make install
