#!/tools/bin/bash
# this scripts is used after chroot
# /root hierarchy
[ ! -d /bin ] && mkdir -v /bin
[ ! -d /boot ] && mkdir -v /boot
[ ! -d /etc ] && mkdir -v /etc
[ ! -d /etc/opt ] && mkdir -pv /etc/opt
[ ! -d /etc/sysconfig ] && mkdir -pv /sysconfig
[ ! -d /home ] && mkdir -v /home
[ ! -d /lib ] && mkdir -v /lib
[ ! -d /lib/firmware ] && mkdir -pv /lib/firmware
[ ! -d /mnt ] && mkdir -v /mnt
[ ! -d /opt ] && mkdir -v /opt
[ ! -d /media ] && mkdir -v /media
[ ! -d /media/floppy ] && mkdir -pv /media/floppy
[ ! -d /media/cdrom ] && mkdir -pv /media/cdrom
[ ! -d /sbin ] && mkdir -v /sbin
[ ! -d /srv ] && mkdir -v /srv
[ ! -d /var ] && mkdir -v /var

# in most case, directory with permission 755
# but /root should not
[ ! -d /root ] && install -dv -m 0750 /root
# public directory, but any cannot remove another user's files
[ ! -d /tmp ] && install -dv -m 1777 /tmp
[ ! -d /var/tmp ] && install -dv -m 1777 /var/tmp

# /usr hierarchy
[ ! -d /usr ] && mkdir -v /usr
[ ! -d /usr/bin ] && mkdir -v /usr/bin
[ ! -d /usr/include ] && mkdir -v /usr/include
[ ! -d /usr/lib ] && mkdir -v /usr/lib
[ ! -d /usr/local ] && mkdir -vp /usr/local
[ ! -d /usr/sbin ] && mkdir -v /usr/sbin
[ ! -d /usr/share ] && mkdir -v /usr/share
[ ! -d /usr/src ] && mkdir -v /usr/src
[ ! -d /usr/local/bin ] && mkdir -v /usr/local/bin
[ ! -d /usr/local/include ] && mkdir -v /usr/local/include
[ ! -d /usr/local/lib ] && mkdir -v /usr/local/lib
[ ! -d /usr/local/sbin ] && mkdir -v /usr/local/sbin
[ ! -d /usr/local/src ] && mkdir -v /usr/local/src

[ ! -d /usr/share/color ] && mkdir -v /usr/share/color
[ ! -d /usr/share/dict ] && mkdir -v /usr/share/dict
[ ! -d /usr/share/doc ] && mkdir -v /usr/share/doc
[ ! -d /usr/share/info ] && mkdir -v /usr/share/info
[ ! -d /usr/share/locale ] && mkdir -v /usr/share/locale
[ ! -d /usr/share/man ] && mkdir -v /usr/share/man
[ ! -d /usr/share/misc ] && mkdir -v /usr/share/misc
[ ! -d /usr/share/terminfo ] && mkdir -v /usr/share/terminfo
[ ! -d /usr/share/zoneinfo ] && mkdir -v /usr/share/zoneinfo

[ ! -d /usr/local/share ] && mkdir -v /usr/local/share
[ ! -d /usr/local/share/color ] && mkdir -v /usr/local/share/color
[ ! -d /usr/local/share/dict ] && mkdir -v /usr/local/share/dict
[ ! -d /usr/local/share/doc ] && mkdir -v /usr/local/share/doc
[ ! -d /usr/local/share/info ] && mkdir -v /usr/local/share/info
[ ! -d /usr/local/share/locale ] && mkdir -v /usr/local/share/locale
[ ! -d /usr/local/share/man ] && mkdir -v /usr/local/share/man
[ ! -d /usr/local/share/misc ] && mkdir -v /usr/local/share/misc
[ ! -d /usr/local/share/terminfo ] && mkdir -v /usr/local/share/terminfo
[ ! -d /usr/local/share/zoneinfo ] && mkdir -v /usr/local/share/zoneinfo

[ ! -d /usr/libexec ] && mkdir -v /usr/libexec

for i in {1..8}; do
    [ ! -d /usr/share/man/man$i ] && mkdir -v /usr/share/man/man$i
    [ ! -d /usr/local/share/man/man$i ] && mkdir -v /usr/local/share/man/man$i
done

[ $(uname -m) == "x86_64" -a ! -d /lib64 ] && mkdir -v /lib64

# /var hierarchy
[ ! -d /var/cache ] && mkdir -v /var/cache
[ ! -d /run/lock ]  && mkdir -v /run/lock
[ ! -s /var/lock ]  &&  ln -sv /run/lock /var/lock
[ ! -d /var/local ] && mkdir -v /var/local
[ ! -d /var/lib ] && mkdir -v /var/lib
[ ! -d /var/log ] && mkdir /var/log
[ ! -d /var/mail ] && mkdir /var/mail
[ ! -d /var/opt ] && mkdir -v /var/opt
[ ! -s /var/run ]  &&  ln -sv /run /var/run
[ ! -d /var/spool ] && mkdir /var/spool
[ ! -d /var/lib/color ] && mkdir -v /var/lib/color
[ ! -d /var/lib/misc ] && mkdir -v /var/lib/misc
[ ! -d /var/lib/locate ] && mkdir -v /var/lib/locate

# log file
mklog(){
    # /var/log/wtmp, records all logins and logouts
    # /var/log/lastlog, each user last login
    # /var/log/faillog, record failed login attemps
    # /var/log/btmp record bad login attempts
    # /run/utmp records logged users dynamically, and created by boot srcipts
    touch /var/log/{btmp,lastlog,faillog,wtmp}
    chgrp -v utmp /var/log/lastlog
    chmod -v 664 /var/log/lastlog
    chmod -v 600 /var/log/btmp
}
mklog
