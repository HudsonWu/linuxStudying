CD's and DVDs are using ISO9660 filesystem. the aim of ISO9660 is to provide a data exchange standard between various operating systems.
1. detecting CD/DVD-ROM drives
wodim --devices
# if a wodim command is not available on your system make sure cdrecord package is installed on your system(apt-get install wodim OR apt-get install cdrecord)
OR
blkid (Locate Block device)
2. creating mount point
mkdir /media/cdrom
3. mount cdrom
mount -t iso9660 /dev/scd0 /media/cdrom
4. umount and eject CDROM
umount /dev/scd0
eject
OR(if you are having problems to umount your CDROM medium)
fuser -mk /dev/scd0
eject
5. testing for ISO9660 support
cat /proc/filesystems | grep iso9660
OR
lsmode | grep iso9660

