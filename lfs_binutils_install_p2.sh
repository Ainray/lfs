#!/bin/bash
# reinstall by cross-compiler
BINUTIL="binutils-2.30.tar.xz"
[ ! -d ${BINUTIL%.tar.xz} ] && echo "tar -xf ${BINUTIL}" && tar -xf ${BINUTIL}

echo "cd ${BINUTIL%.tar.xz}"
cd ${BINUTIL%.tar.xz}

[ -d build ] &&  rm -rf build && mkdir -v build

echo "cd build"
cd build

CC=$LFS_TGT-gcc
AR=$LFS_TGT-ar
RANLIB=$LFS_TGT-ranlib


# i18n are disabled temporarily
../configure --prefix=/tools --with-sysroot\
    --with-lib-path=/tools/lib \
    --disable-nls --disable-werror

# for X86_64
$ [ $(uname -m) == "x86_64" -a ! -s /tools/lib64 ] && mkdir -v /tools/lib && ln -sv lib /tools/lib64

make 
make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin
