#!/bin/bash
cd /sources
READLINE="readline-7.0.tar.gz"
[ ! -d ${READLINE%.tar.gz} ] && echo "tar -xf ${READLINE}" && tar -xf ${READLINE}
echo "cd ${READLINE%.tar.gz}"
cd ${READLINE%.tar.gz}

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

./configure --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/readline-7.0
    

make SHLIB_LIBS="-L/tools/lib -lncursesw"
make SHLIB_LIBS="-L/tools/lib -lncursesw" install
mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so) /usr/lib/libhistory.so
install -v m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-7.0
