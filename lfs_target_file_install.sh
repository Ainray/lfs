#!/bin/bash
cd /sources
FILE="file-5.32.tar.gz"
[ ! -d ${FILE%.tar.gz} ] && echo "tar -xf ${FILE}" && tar -xf ${FILE}
echo "cd ${FILE%.tar.gz}"
cd ${FILE%.tar.gz}

./configure --prefix=/usr

make
make check
make install
