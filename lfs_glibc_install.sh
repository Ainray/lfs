#!/bin/bash
GLIBC="glibc-2.27.tar.xz"
echo "tar -xf ${GLIBC}"
tar -xf ${GLIBC}
echo "cd ${GLIBC%.tar.xz}"
cd ${GLIBC%.tar.xz}
mkdir -v build
echo "cd build"
cd build
# 3.2 and later kernel,
# linker installed during lfs_binutils_install.sh
# cannot used until glibc has been installed
#   libc_cv_forced_unwind=yes and libc_cv_c_cleanup=yes
# inform configure to skip test
../configure --prefix=/tools --host=$LFS_TGT  \
    --build=$(../scripts/config.guess) \
    --enable-kernel=3.2 \
    --with-headers=/tools/include \
    libc_cv_forced_unwind=yes \
    libc_cv_c_cleanup=yes

# if parallel make failed use 
# make -j1
make 
make install
