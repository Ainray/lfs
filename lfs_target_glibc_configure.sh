#!/bin/bash
# nsswitch.conf
# move this command into lfs_chroot for convenience
# install -Dm644 lfs_nsswitch /etc/nsswitch.conf

echo "cd /sources"
cd /sources

# time zone
echo "tar -xf tzdata2018c.tar.gz"
tar -xf tzdata2018c.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

# zic -L /dev/null, creates posix time zones without leap seconds
# zic -L leapseconds  creates right time zones with leap secones
# in some embedded system, you maybe want to save right directory 
# to save or 1.9MB
for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

# create posix rules file
cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

ln -sfv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# dynamical lib directory
echo '# Begin /etc/ld.so.conf
/usr/local/lib
opt/lib

# add an include directory
include /etc/ld.so.conf.d/*.conf' > /etc/ld.so.conf

mkdir -pv /etc/ld.so.conf.d

