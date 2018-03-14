#!/bin/bash
EXPECT="expect5.45.4.tar.gz"
echo "tar -xf ${EXPECT}"
tar -xf ${EXPECT}
echo "cd ${EXPECT%.tar.gz}"
cd ${EXPECT%.tar.gz}
cp -v configure{,.orig}
# : as usual usage "/"
sed 's:/usr/local/bin:/bin:' configure.orig > configure
./configure --prefix=/tools --with-tcl=/tools/lib \
    --with-tclinclude=/tools/include

make

# not mandatory, I will test for final tools
# make test

# prevents installation supplementary expect srcipts
make SCRIPTS="" install
