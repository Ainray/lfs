#!/bin/bash
UTILLINUX="util-linux-2.31.1.tar.xz"
echo "tar -xf ${UTILLINUX}"
tar -xf ${UTILLINUX}
echo "cd ${UTILLINUX%.tar.xz}"
cd ${UTILLINUX%.tar.xz}

# disable using python
# do not need to use chown when installing into /tools 
# do not use ncurses for the build process
# prevent unneeded features, when using configure 
# variable can be before configure command or after it like this.


./configure --prefix=/tools \
    --without-pythton \
    --disable-makeinstall-chown \
    --without-ncurses \
    --without-systemdsystemunitdir \
    --without-ncurses \
    PKG_CONFIG=""

make

make install
