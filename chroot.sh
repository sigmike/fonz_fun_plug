#!/ffp/bin/sh
set -x

CWD=$(pwd)

ffp=$(readlink -f /ffp)
root=/ffp-chroot


if [ -d "$root" ]; then
	echo "$root exists"
	exit 1
fi

mkdir -p $root
cd $root
mkdir -p ffp dev etc proc sys mnt mnt/HD_a2

mount -t proc proc proc
mount -t sysfs sysfs sys
mount --bind /dev dev
mount --bind /etc etc
mount --bind $ffp ffp
mount --bind /mnt/HD_a2 mnt/HD_a2

ln -s ffp/bin bin
ln -s ffp/lib lib
ln -s ffp/sbin sbin
ln -s ffp usr

chroot . $SHELL

umount mnt/HD_a2
umount ffp
umount etc
umount dev

umount sys
umount proc

rm bin lib sbin usr
rmdir ffp dev etc proc sys mnt/HD_a2 mnt
cd ..
rmdir $root


