#!/bin/bash
FILE="file-5.32.tar.gz"
echo "tar -xf ${FILE}"
tar -xf ${FILE}
echo "cd ${FILE%.tar.gz}"
cd ${FILE%.tar.gz}

./configure --prefix=/tools

make 

# test
# make check

make install
