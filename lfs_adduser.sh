#!/bin/bash
# should be run as root

[ $(id -u) -ne 0 ] && echo "Please run as root:" && exit 1

LFSUSER=lfs0
LFSPASSWD=520

groupadd ${LFSUSER}

# -m, create home directory for lfs,
# -k, prevent copy skeleton files and  directories copied to 
#     /home/lfs from (usually /etc/skel) 
useradd -s /bin/bash -g lfs -p ${LFSPASSWD} -m -k /dev/null ${LFSUSER}

echo "add user ${LFSUSER}"
LFS=/mnt/${LFSUSER}
mkdir -v $LFS
mkdir -v $LFS/sources
mkdir -v $LFS/tools

# create /tools symblink
ln -vs $LFS/tools /  
chown ${LFSUSER}:${LFSUSER} -R $LFS

# mount -t ext4 /dev/sda10 $LFS
# When you restart, you maybe want the target  root file system to be
# mounted automatically, push in /etc/fstab file as follows:
# /etc/fstab: static file system information.
# uuid is obtained by blkid, uid is get by id -u,
# and gid is get by id -g, tailing \ is line continuation
# in /etc/fstab, put these two logical lines in one physical line

# UUID=cd3d6d06-79a0-4972-94bf-d4243a092b1a /mnt/lfs ext4 \
#    usrname=inray,rw,uid=1000,gid=1000,umask=0022,auto 0 2
