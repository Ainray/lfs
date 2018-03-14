#!/bin/bash
BINUTIL="binutils-2.30.tar.xz"
echo "tar -xf ${BINUTIL}"
tar -xf ${BINUTIL}

echo "cd ${BINUTIL%.tar.xz}"
cd ${BINUTIL%.tar.xz}

mkdir -v build

echo "cd build"
cd build

# i18n are disabled temporarily
../configure --prefix=/tools  --with-sysroot=$LFS \
    --with-lib-path=/tools/lib --target=$LFS_TGT \
    --disable-nls --disable-werror

# for X86_64
$ [ $(uname -m) == "x86_64" ] && mkdir -v /tools/lib && ln -sv lib /tools/lib64

make 
make install
