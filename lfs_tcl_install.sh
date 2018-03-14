#!/bin/bash
TCL="tcl8.6.8-src.tar.gz"
echo "tar -xf ${TCL}"
tar -xf ${TCL}
echo "cd ${TCL%-src.tar.gz}"
cd ${TCL%-src.tar.gz}
cd unix
./configure --prefix=/tools
make

# not mandatory, I will test for final tools
# TZ=UTC make test

make install

# give write permission for future delete
chmod -v u+w /tools/lib/libtcl8.6.so

# install tcl' headers
make install-private-headers
ln -sv tclsh8.6  /tools/bin/tclsh

