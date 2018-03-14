#!/bin/bash
set -e
GCC="gcc-7.3.0.tar.xz"
[ ! -d ${GCC%.tar.xz} ] && echo "tar -xf ${GCC}" && tar -xf ${GCC}
echo "cd ${GCC%.tar.xz}"
cd ${GCC%.tar.xz}
#prepare mpfr, gmp, mpc
[ ! -d mpc ] && tar -xf ../mpc-1.1.0.tar.gz && mv -v mpc-1.1.0/ mpc
[ ! -d mpfr ] && tar -xf ../mpfr-4.0.1.tar.xz && mv -v mpfr-4.0.1 mpfr
[ ! -d gmp ] && tar -xf ../gmp-6.1.2.tar.xz  && mv -v gmp-6.1.2/ gmp

# before you run this script, please first make a backup 
# and test first.
# check changes in  gcc/config/linux.h  gcc/config/i386/linux.h,
#                   gcc/config/i386/linux64.h
#
# {a,b} no space before b
# in usual way, file will be match gcc/config/linux.h
# gcc/config/i386/linux.h, gcc/config/i386/linux64.h

for file in gcc/config/{linux,i386/linux{,64}}.h
do 
    # copy file into file.orig, only file is newer than file.orig
    cp -uv $file{,.orig}
    # @ used as delimiter as usual usage "/"
    # \(\) sub matches, \? zero or one
    # so add /lib/ld, /lib64/ld, /lib32/ld with prefix /tools
    # and replace /usr with /tools
    # rename file to original name
    sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
        -e 's@/usr@/tools@g' "${file}.orig" > $file

    # redefine STANDARD_STARTFILE_PREFIX_{1,2}
    echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $file
    echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $file
    echo '#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"' >> $file
    echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file

    # update timestamps, then changed $file will not be renamed
    # just prevent unexpected runtime error
    touch $file.orig 
done

# for X86_64 host
# check gcc/config/i386/t-linux64
[ $(uname -m) == "x86_64" ]  && sed -e '/m64=/s/lib64/lib/' -i.orig \
    gcc/config/i386/t-linux64

# build
[ -d build ] && rm -rf build
mkdir -v build
echo "cd build"
cd build
# configure gcc
# --with-newlib define inhibit_libc constant, prevent any code require lib support
# --without-headers, create cross-compiler, gcc requires standard headers
    # compatible with the target system. For our purposes, these headers will
    # not be needed. This switch prevents gcc from looking for them
# --with-local-prefix, gcc will search locally installed include files
    # default value is /usr/local
# --with-native-system-header-dir, by default, gcc search /usr/include
    # with --with-sysroot, gcc will search $LFS/usr/include
# --disable-shared, force gcc link internal libraries statically
# --disable-decimal-float --disable-threads --disable-libatomic
    # --disable-libgomp --disable-libmpx --disable-libquadmath
    # --disable-libssp --disable-libvtv --disable-libstdcxx
    # these will failed when building a cross-compiler and 
    # unnecessary for a temporary libc to to cross-compiling
# --disable-multilib, 
# --enable-languages=c,c++
CC=$LFS_TGT-gcc
CXX=$LFS_TGT-g++
AR=$LFS_TGT-ar
RANLIB=$LFS_TGT-ranlib
../configure --prefix=/tools \
    --with-local-prefix=/tools  \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++ \
    --disable-libstdcxx-pch \
    --disable-multilib  \
    --disable-bootstrap \
    --disable-libgomp 
make
make install
ln -sv gcc /tools/bin/cc
