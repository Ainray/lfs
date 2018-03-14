
        $ mkdir -v /mnt/lfs/usr /mnt/lfs/boot /mnt/lfs/home /mnt/lfs/opt/ 
         /mnt/lfs/tmp
        $ sudo mount -vt ext4 /dev/sda11 /mnt/lfs/boot
        $ sudo mount -vt ext4  /dev/sda13 /mnt/lfs/home
        $ sudo mount -vt ext4 /dev/sda14 /mnt/lfs/usr
        $ sudo mount -vt ext4 /dev/sda15 /mnt/lfs/opt
        $ sudo mount -vt ext4 /dev/sda16 /mnt/lfs/tmp
    Enable swap by
        $ sudo /sbin/swapon -v /dev/sda12
check by
        $ free -h
you should notice your swap is enlarged.  If you are not sure, you can close
swap by 
        $ sudo /sbin/swapoff -v /dev/sda12
then check by "free -h" again.


    When you after reboot, these manually mounted partitions will does not work,
so add them into your /etc/fstab file.
    Here is my /etc/fstab, 

            # /etc/fstab: static file system information.
            #
            #
            # lfs file systems follow:
            #
            UUID=09550571-f4fd-46dd-9139-25a74478c681 /mnt/lfs/boot          ext4    usrname=inray,rw,uid=1000,gid=1000,umask=0022,auto 0 2
            UUID=9b3bd006-fb64-4ff0-b947-e664c3e5240a /mnt/lfs/usr           ext4    usrname=inray,rw,uid=1000,gid=1000,umask=0022,auto 0 2
            UUID=50933e77-b31d-424a-b4db-1d784a101831 /mnt/lfs/home          ext4    usrname=inray,rw,uid=1000,gid=1000,umask=0022,auto 0 2
            UUID=9071528d-060c-4cf0-b90c-08f252e156cb /mnt/lfs/opt           ext4    usrname=inray,rw,uid=1000,gid=1000,umask=0022,auto 0 2
            UUID=af92e0be-b6ec-4b7a-8b3d-4b793db5deac /mnt/lfs/tmp           ext4    usrname=inray,rw,uid=1000,gid=1000,umask=0022,auto 0 2
            UUID=0ef25b72-0519-4d30-9a81-b6aaad62644d none 			 swap    sw              	 	0       0

