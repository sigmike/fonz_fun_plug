#!/ffp/bin/sh

PATH=/ffp/sbin:/ffp/bin:$PATH

if [[ -d /usr/local/config/ ]]; then
	echo "Saving Userdata to /usr/local/config/"
	cp -f /etc/passwd /usr/local/config/
	cp -f /etc/group /usr/local/config/
	cp -f /etc/shadow /usr/local/config/
	cp -f /etc/samba/smbpasswd /usr/local/config/
else
	echo "Saving Userdata to flash storage"
	echo "Mounting flash ..."
	mount -t minix /dev/mtdblock0 /sys/mtd1
	mount -t minix /dev/mtdblock1 /sys/mtd2
	echo "Updating files ..."
	for d in /usr/local/config /sys/mtd1 /sys/mtd2 /mnt/HD_a4/.systemfile/AccountFile /mnt/HD_b4/.systemfile/AccountFile; do
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
	echo "Unmounting flash ..."
	sync
	umount /sys/mtd1
	umount /sys/mtd2
fi

