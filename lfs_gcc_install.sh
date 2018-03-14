#!/bin/bash
[[ $_ != $0 ]] && echo "This script should not be sourced." && exit 1
# this source should not be sourced
# set temporary path, that why it should not be sourced
set -e
CURPATH=$(pwd)
PATH="${PATH}:${CURPATH}"

# build gcc based LFS

GCC="${CURPATH}/gcc-7.3.0.tar.xz"
echo "tar -xf ${GCC}"
tar -xf ${GCC}
GCCDIR="${GCC%.tar.xz}"
cd ${GCCDIR}
#prepare mpfr, gmp, mpc
tar -xf ../mpc-1.1.0.tar.gz
tar -xf ../gmp-6.1.2.tar.xz 
tar -xf ../mpfr-4.0.1.tar.xz 
mv -v mpc-1.1.0/ mpc
mv -v gmp-6.1.2/ gmp
mv -v mpfr-4.0.1 mpfr
#
# before you run this script, please first make a backup 
# and test first.
# check changes in  gcc/config/linux.h  gcc/config/i386/linux.h,
#                   gcc/config/i386/linux64.h
#
# {a,b} no space before b
# in usual way, file will be match gcc/config/linux.h
# gcc/config/i386/linux.h, gcc/config/i386/linux64.h

for file in ${GCCDIR}/gcc/config/{linux,i386/linux{,64}}.h
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
    ${GCCDIR}/gcc/config/i386/t-linux64

# build
echo "mkdir -v ${GCCDIR}/build"
mkdir -v ${GCCDIR}/build
echo "cd ${GCCDIR}/build"
cd ${GCCDIR}/build
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
${GCCDIR}/configure --target=$LFS_TGT --prefix=/tools \
    --with-glibc-version=2.11 --with-sysroot=$LFS \
    --with-newlib   --without-headers --with-local-prefix=/tools \
    --with-native-system-header-dir=/tools/include \
    --disable-nls --disable-shared --disable-multilib \
    --disable-decimal-float --disable-threads \
    --disable-libatomic --disable-libgomp \
    --disable-libmpx --disable-libvtv\
    --disable-libquadmath --disable-libssp \
    --disable-libstdcxx \
    --enable-languages=c,c++

make
make install
