#!/bin/sh

echo "Copying files to mtd1..."
mount -t minix /dev/mtdblock0 /sys/mtd1
cp -f /etc/passwd /sys/mtd1/.
cp -f /etc/group /sys/mtd1/.
cp -f /etc/shadow /sys/mtd1/.
cp -f /etc/samba/smbpasswd /sys/mtd1/.
#cp -f /etc/ftp_tbl /sys/mtd1/.
#cp -f /etc/ftpgroup /sys/mtd1/.
sync
umount /sys/mtd1
    
echo "Copying files to mtd2..."
mount -t minix /dev/mtdblock1 /sys/mtd2
cp -f /etc/passwd /sys/mtd2/.
cp -f /etc/group /sys/mtd2/.
cp -f /etc/shadow /sys/mtd2/.
cp -f /etc/samba/smbpasswd /sys/mtd2/.
#cp -f /etc/ftp_tbl /sys/mtd2/.
#cp -f /etc/ftpgroup /sys/mtd2/.
sync
umount /sys/mtd2

echo "Done."
