#!/bin/bash
[ $(id -u) -ne 0 ] && echo "Please run as root:" && exit 1
# first mount virtual file systems
[ ! -d $LFS/dev ] && mkdir -v $LFS/dev
[ ! -d $LFS/proc ] && mkdir -v $LFS/proc
[ ! -d $LFS/sys ] && mkdir -v $LFS/sys
[ ! -d $LFS/run ] && mkdir -v $LFS/run
[ ! -c $LFS/dev/console ] && mknod -m 600 $LFS/dev/console c 5 1
[ ! -c $LFS/dev/null ] && mknod -m 666 $LFS/dev/null c 1 3

# devpts gid=5,mode 0620
#
grep "${LFS}/dev\> " /proc/mounts 2>&1 >/dev/null || mount -v --bind /dev $LFS/dev
grep "${LFS}/dev/pts\> " /proc/mounts 2>&1 >/dev/null || mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
grep "${LFS}/proc\> " /proc/mounts 2>&1 >/dev/null || mount -vt proc proc  $LFS/proc
grep "${LFS}/sys\> " /proc/mounts 2>&1 >/dev/null || mount -vt sysfs sysfs $LFS/sys
grep "${LFS}/run\> " /proc/mounts 2>&1 >/dev/null || mount -vt tmpfs tmpfs $LFS/dev

if [ -h $LFS/dev/shm ]; then 
	shmdir=$(readlink $LFS/dev/shm)
	[ ! -d $LFS/$shmdir ]  && mkdir -pv $LFS/$shmdir
fi
# install passwd and group file
[ ! -d ${LFS}/etc ] && mkdir ${LFS}/etc
[ ! -f ${LFS}/etc/passwd ]  && install -m644 lfs_passwd $LFS/etc/passwd
[ ! -f ${LFS}/etc/group ]  && install -m644 lfs_group $LFS/etc/group

# change root now
chroot "$LFS" /tools/bin/env -i \
	HOME=/root \
	TERM="${TERM}" \
	PS1='(lfs chroot)\u@\w$ ' \
	PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin:/lfslog \
	/tools/bin/bash --login +h
