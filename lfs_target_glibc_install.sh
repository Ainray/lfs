#!/bin/bash
cd /sources
GLIBC="glibc-2.27.tar.xz"
[ ! -d ${GLIBC%.tar.xz} ] && echo "tar -xf ${GLIBC}" && tar -xf ${GLIBC}
echo "cd ${GLIBC%.tar.xz}"
cd ${GLIBC%.tar.xz}

# patch
patch -Np1 -i ../glibc-2.27-fhs-1.patch

# avoid references to /tools in our final glibc
ln -sfv /tools/lib/gcc /usr/lib


# determine gcc include directory and create a symblink for LSB compliance
case $(uname -m) in
    i?86) GCC_INCDIR=/usr/lib/gcc/$(uname -m)-pc-linux-gnu/7.3.0/include
        ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
        ;;
    x86_64) GCC_INCDIR=/usr/lib/gcc/x86_64-pc-linux-gnu/7.3.0/include
        ln -sfv ../lib/ld-linux-x86_64.so.2 /lib64
        ln -sfv ../lib/ld-linux-x86_64.so.2 /lib64/ld-lsb-x86_64.so.3
        ;;
esac

# remove previous file
rm -f /usr/include/limits.h

[ -d build ] && rm -rf build
mkdir -v build
echo "cd build"
cd build


# 3.2 and later kernel,
# --disable-werror, for test suite
# --enable-stack-protector=strong, adding buffer overflows check
# --libc_cv_slibdir, library path,  not lib64
CC="gcc -isystem $GCC_INCDIR -isystem /usr/include" \
../configure --prefix=/usr \
    --disable-werror    \
    --enable-kernel=3.2 \
    --enable-stack-protector=strong \
    libc_cv_slibdir=/lib

unset GCC_INCDIR

make  -j1
# test is critical here
make check

# prevent warning
touch /etc/ld.so.conf
# skip unneeded sanity check which fails in LFS partial environment
sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

make install
# install configuration file and runtime directory for nscd
cp -v ../nscd/nscd.conf /etc/nscd.conf
mkdir -pv /var/cache/nscd

install -v -Dm644 ../nscd/nscd.tmpfiles /usr/lib/tmpfiles.d/nscd.conf
install -v -Dm644 ../nscd/nscd.service /lib/systemd/system/nscd.service


# install locales
[ ! -d /usr/lib/locale ] && mkdir -pv /usr/lib/locale
# install all locales is time-consuming
make localedata/install-locales

# localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
# localedef -i de_DE -f ISO-8859-1 de_DE
# localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
# localedef -i de_DE -f UTF-8 de_DE.UTF-8
# localedef -i en_GB -f UTF-8 en_GB.UTF-8
# localedef -i en_HK -f ISO-8859-1 en_HK
# localedef -i en_PH -f ISO-8859-1 en_PH
# localedef -i en_US -f ISO-8859-1 en_US
# localedef -i en_US -f UTF-8 en_US.UTF-8
# localedef -i es_MX -f ISO-8859-1 es_MX
# localedef -i fa_IR -f UTF-8 fa_IR
# localedef -i fr_FR -f ISO-8859-1 fr_FR
# localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
# localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
# localedef -i it_IT -f ISO-8859-1 it_IT
# localedef -i it_IT -f UTF-8 it_IT.UTF-8
# localedef -i ja_JP -f EUC-JP ja_JP
# localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
# localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
# localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
# localedef -i zh_CN -f GB18030 zh_CN.GB18030
