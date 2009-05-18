#!/ffp/bin/sh

PATH=/ffp/sbin:/ffp/bin:$PATH

echo "Mounting flash ..."
mount -t minix /dev/mtdblock0 /sys/mtd1
mount -t minix /dev/mtdblock1 /sys/mtd2

echo "Updating files ..."
for d in /sys/mtd1 /sys/mtd2 /mnt/HD_a4/.systemfile/AccountFile /mnt/HD_b4/.systemfile/AccountFile; do
    if [ -d "$d" ]; then
	for f in /etc/passwd /etc/group /etc/shadow /etc/samba/smbpasswd; do
	    b=$(basename $f)
	    if [ -e "$d/$b" ]; then
		echo "  $d/$b"
		cp -f $f $d
	    fi
	done
    fi
done

echo "Unmounting ..."
sync
umount /sys/mtd1
umount /sys/mtd2

echo "Done."
