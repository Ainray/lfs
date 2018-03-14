#!/bin/bash
NCURSES="ncurses-6.1.tar.gz"
echo "tar -xf ${NCURSES}"
tar -xf ${NCURSES}
echo "cd ${NCURSES%.tar.gz}"
cd ${NCURSES%.tar.gz}

# use gawk
sed -i s/mawk// configure

# do not support ada compiler, because target 
# do not have ada after chroot
# --enable-overwrite tells ncurses install its 
    # headers into /tools/include instead of /tools/include/ncurses
# --enable-widec wide-character libraries, for example, libncursesw.so.6.1
    # instead of normal libcurses.so.6.1
./configure --prefix=/tools \
    --with-shared \
    --with-debug \
    --without-ada \
    --enable-widec \
    --enable-overwrite
     

make 
make install
