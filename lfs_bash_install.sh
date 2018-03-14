#!/bin/bash
BASH="bash-4.4.18.tar.gz"
echo "tar -xf ${BASH}"
tar -xf ${BASH}
echo "cd ${BASH%.tar.gz}"
cd ${BASH%.tar.gz}

# disable bash memory allocation which is known to cause 
# segmentation faults, bash will use glibc malloc
./configure --prefix=/tools \
    --without-bash-malloc
     

make 
# test
# make test
make install

ln -sv bash /tools/bin/sh
