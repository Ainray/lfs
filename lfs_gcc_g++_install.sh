#!/bin/bash
set -e
GCC="gcc-7.3.0.tar.xz"
[ ! -d ${GCC%.tar.xz} ] && echo "tar -xf ${GCC}" && tar -xf ${GCC}
echo "cd ${GCC}"
cd ${GCC%.tar.xz}
[ ! -d build ] && mkdir -v build  
echo "cd build" && cd build
# disable threads library
../libstdc++-v3/configure --host=$LFS_TGT  \
    --prefix=/tools --disable-multilib \
    --disable-nls  --disable-libstdcxx-threads \
    --disable-libstdcxx-pch \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/7.3.0

make
make install
