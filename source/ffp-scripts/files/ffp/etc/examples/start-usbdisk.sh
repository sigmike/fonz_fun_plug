#!/ffp/bin/sh

# PROVIDES: usbdisk
# BEFORE: LOGIN
# REQUIRE: SERVERS

. /ffp/etc/ffp.subr

# see
# "Attaching USB Storage to the DNS-323 for Linux Newbies & Dummies"
# http://forum.dsmg600.info/viewtopic.php?pid=3221#p3221

# usb-storage.ko module:
#  http://www.domaigne.com/download/dns-323/usb-storage.ko

name="usbdisk"
start_cmd="usbdisk_start"
stop_cmd="usbdisk_stop"
status_cmd="usbdisk_status"

usbdisk_mount_options="-t auto"
#usbdisk_mount_options="-t auto -o umask 0"

usbdisk_dev="sdb1"
#usbdisk_dev="sdc1"
usbdisk_mountp="/mnt/HD_a2/$usbdisk_dev"

usbdisk_start()
{
    insmod /ffp/lib/modules/$(uname -r)/usb-storage.ko 2>/dev/null
    #insmod /ffp/lib/modules/$(uname -r)/ntfs.ko        2>/dev/null
    
    # wait for disk...
    grep -w $usbdisk_dev /proc/partitions >/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        let timeout=60
        echo "Waiting for $usbdisk_dev (up to $timeout seconds) ..."
        while [ $timeout -gt 0 ]; do
            grep -w $usbdisk_dev /proc/partitions >/dev/null 2>/dev/null
            [ $? -eq 0 ] && break
            sleep 2
            let timeout=${timeout}-2
        done
        grep -w $usbdisk_dev /proc/partitions >/dev/null 2>/dev/null
        if [ $? -ne 0 ]; then
            echo "Failed. Did not find $usbdisk_dev in /proc/partitions."
            exit 1
        fi
    fi

    # mount it
    mkdir -p $usbdisk_mountp
    echo "Mounting /dev/$usbdisk_dev on $usbdisk_mountp"
    mount $usbdisk_mount_options /dev/$usbdisk_dev $usbdisk_mountp >$usbdisk_mountp/mount-error.txt 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed"
        cat $usbdisk_mountp/mount-error.txt
    fi
}

usbdisk_stop()
{
    mount | grep $usbdisk_mountp >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Unmounting $usbdisk_mountp"
        umount $usbdisk_mountp
    else
        echo "Nothing mounted on $usbdisk_mountp"
    fi
}

usbdisk_status()
{
    mount | grep $usbdisk_mountp 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "$usbdisk_dev is not mounted"
    fi
}

run_rc_command "$1"
