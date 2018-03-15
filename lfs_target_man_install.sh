#!/bin/bash
cd /sources
MAN="man-pages-4.15.tar.xz"
[ ! -d ${MAN%.tar.xz} ] && echo "tar -xf ${MAN}" && tar -xf ${MAN}
echo "cd ${MAN%.tar.xz}"
cd ${MAN%.tar.xz}

make install
