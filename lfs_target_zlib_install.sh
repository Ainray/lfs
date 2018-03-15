#!/bin/bash
cd /sources
ZLIB="zlib-1.2.11.tar.xz"
[ ! -d ${ZLIB%.tar.xz} ] && echo "tar -xf ${ZLIB}" && tar -xf ${ZLIB}
echo "cd ${ZLIB%.tar.xz}"
cd ${ZLIB%.tar.xz}

./configure --prefix=/usr

make
make check
make install
mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so
