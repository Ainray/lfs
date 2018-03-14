#!/bin/bash

cd $LFS/sources
wget --input-file=wget-list-working -c --directory-prefix=$LFS/sources
md5sum -c md5sum
