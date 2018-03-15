#!/bin/bash
# test 6.10
echo "int main(){}" > dummy.c
cc dummy.c -v -Wl,--verbose &> lfs_target_test_6.10_dummy.log
readelf -l a.out |grep ': /lib'

grep -o '/usr/lib.*crt[1in].*succeeded' lfs_target_test_6.10_dummy.log
grep -B1 '^ /usr/include' lfs_target_test_6.10_dummy.log
grep 'SEARCH.*/usr/lib' lfs_target_test_6.10_dummy.log |sed 's|; |\n|g'
grep '/lib.*/lib/libc.so.6' lfs_target_test_6.10_dummy.log
grep found lfs_target_test_6.10_dummy.log
