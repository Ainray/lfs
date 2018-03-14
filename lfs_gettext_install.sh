#!/bin/bash
GETTEXT="gettext-0.19.8.1.tar.xz"
echo "tar -xf ${GETTEXT}"
tar -xf ${GETTEXT}
echo "cd ${GETTEXT%.tar.xz}"
cd ${GETTEXT%.tar.xz}

# only install part of gettext
# prevent configure from determing where to install EMACS Lisp
# files as the test it known to hang on some hosts
# no shared libraries at this time
cd gettext-tools
EMACS="no" ./configure --prefix=/tools  --disable-shared

make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

# no test at the time, because whole gettext library is installed
