#!/bin/bash
PERL="perl-5.26.1.tar.xz"
echo "tar -xf ${PERL}"
tar -xf ${PERL}
echo "cd ${PERL%.tar.xz}"
cd ${PERL%.tar.xz}

sh Configure -des -Dprefix=/tools -Dlibs=-lm

make

# test
# no test at the time
cp -v perl cpan/podlators/scripts/pod2man /tools/bin
mkdir -pv    /tools/lib/perl5/5.26.1
cp -Rv lib/* /tools/lib/perl5/5.26.1
