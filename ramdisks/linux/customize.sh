#!/bin/bash

# busybox links
cd $D
/bin/bash ./ffp/bin/install-busybox-links.sh

# install init
install -o root -g root -m 0755 $X/files/init $D/init

# remove cruft
cd $D/ffp
rm -rf etc/examples
rm -rf include
rm -rf lib/*.a lib/*.la
rm -rf share/doc share/info share/man
rm -rf share/tabset share/terminfo

# uneeded
cd $D/ffp
rm -rf start var/packages

# we don't use mdev in this ramdisk, but a predefined set of devices
cd $D
mkdir -p dev
cd dev

mknod -m 0666 null         c 1 3
mknod -m 0666 zero         c 1 5

mkdir -p pts shm
ln -s /proc/kcore       core
ln -s /proc/self/fd     fd
ln -s /proc/self/fd/0   stdin
ln -s /proc/self/fd/1   stdout
ln -s /proc/self/fd/2   stderr

mknod -m 0660 ram0	b 1 0
mknod -m 0660 random	c 1 8
mknod -m 0660 urandom	c 1 9
mknod -m 0660 initrd	b 1 250

mknod -m 0660 tty0	c 4 0
mknod -m 0660 tty1	c 4 1
mknod -m 0660 tty2	c 4 2
mknod -m 0660 tty3	c 4 3
mknod -m 0660 ttyS0	c 4 64
mknod -m 0660 ttyS1	c 4 65

mknod -m 0666 tty	c 5 0
mknod -m 0600 console	c 5 1
mknod -m 0666 ptmx	c 5 2

mknod -m 0660 loop0	b 7 0

mknod -m 0640 sda	b 8 0
mknod -m 0640 sda1	b 8 1
mknod -m 0640 sda2	b 8 2
mknod -m 0640 sda3	b 8 3
mknod -m 0640 sda4	b 8 4
mknod -m 0640 sda5	b 8 5
mknod -m 0640 sda6	b 8 6
mknod -m 0640 sda7	b 8 7
mknod -m 0640 sda8	b 8 8

mknod -m 0640 sdb	b 8 16
mknod -m 0640 sdb1	b 8 17
mknod -m 0640 sdb2	b 8 18
mknod -m 0640 sdb3	b 8 19
mknod -m 0640 sdb4	b 8 20
mknod -m 0640 sdb5	b 8 21
mknod -m 0640 sdb6	b 8 22
mknod -m 0640 sdb7	b 8 23
mknod -m 0640 sdb8	b 8 24

mknod -m 0640 sdc	b 8 32
mknod -m 0640 sdc1	b 8 33
mknod -m 0640 sdc2	b 8 34
mknod -m 0640 sdc3	b 8 35
mknod -m 0640 sdc4	b 8 36
mknod -m 0640 sdc5	b 8 37
mknod -m 0640 sdc6	b 8 38
mknod -m 0640 sdc7	b 8 39
mknod -m 0640 sdc8	b 8 40

mknod -m 0640 sdd	b 8 48
mknod -m 0640 sdd1	b 8 49
mknod -m 0640 sdd2	b 8 50
mknod -m 0640 sdd3	b 8 51
mknod -m 0640 sdd4	b 8 52
mknod -m 0640 sdd5	b 8 53
mknod -m 0640 sdd6	b 8 54
mknod -m 0640 sdd7	b 8 55
mknod -m 0640 sdd8	b 8 56

mknod -m 0660 md0	b 9 0
mknod -m 0660 md1	b 9 1

mknod -m 0660 rtc	c 10 135

# make it look like a rootfs
cd $D
ln -s ffp/etc etc
ln -s ffp/bin bin
ln -s ffp/sbin sbin
ln -s ffp/lib lib
ln -s ffp usr
mkdir -p proc sys tmp mnt
chmod 01777 tmp

