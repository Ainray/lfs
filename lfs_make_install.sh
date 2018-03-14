#!/bin/bash
MAKE="make-4.2.1.tar.bz2"
echo "tar -xf ${MAKE}"
tar -xf ${MAKE}
echo "cd ${MAKE%.tar.bz2}"
cd ${MAKE%.tar.bz2}

# work around an error caused by glibc-2.27
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c

# do not link guile libraries, which won't be 
# available  within target after chroot
./configure --prefix=/tools --without-guile

make

# test
# make check

make install
