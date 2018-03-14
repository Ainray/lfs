#!/bin/bash

# .bash_lfs
[ ! -f ~/.bash_lfs ] && \
echo '#  .bash_lfs 
#  special by Linux from scratch
#  it is sourced by bash startup file
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin/:/bin:/usr/bin:.:${HOME}/.bash
export LFS LC_ALL LFS_TGT PATH 
pathaddmul "/mnt/lfs" CDPATH

# make use dual CPU
# can also by make -j2
export MAKEFLAGS=" -j 2"' > ~/.bash \
&& echo '# Linux from scratch
if [ -f ~/.bash_lfs ]; then
     . ~/.bash_lfs
fi' >> ~/.bash_profile \
echo '# Linux from scratch
if [ -f ~/.bash_lfs ]; then
     . ~/.bash_lfs
fi' >> ~/.bashrc

echo "Environment check:"
echo LFS=$LFS
echo LFS_TGT=$LFS_TGT
