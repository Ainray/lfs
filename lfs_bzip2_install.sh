#!/bin/bash
BZ2="bzip2-1.0.6.tar.gz"
echo "tar -xf ${BZ2}"
tar -xf ${BZ2}
echo "cd ${BZ2%.tar.gz}"
cd ${BZ2%.tar.gz}

make 
make PREFIX=/tools install
