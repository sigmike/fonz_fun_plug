#!/ffp/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $(basename $0) [-k kernel] [-r initrd] [-m machtype] [-I] kernel command line"
    echo " -I  try IP autonconf"
    exit 1
fi

die() 
{
        cat <<EOF
ERROR: $@
EOF
        exit 1
}

kernel=$(readlink -f zImage)
initrd=
machtype=1542
cmdline="console=ttyS0,115200"

ip_autoconf=

_opts=$(getopt k:r:m:I "$@") || exit 1
eval set -- "$_opts"
while true; do
    case "$1" in
	-k)
	    kernel="$(readlink -f $2)"
	    shift 2
	    ;;
	-r)
	    initrd="$(readlink -f $2)"
	    shift 2
	    ;;
	-m)
	    machtype="$2"
	    shift 2
	    ;;
	-I)
	    ip_autoconf=1
	    shift
	    ;;
	--)
	    shift
	    break
	    ;;
	*)
	    die "getopt error"
	    ;;
    esac
done

if [ $# -gt 0 ]; then
    cmdline="$cmdline $@"
fi

# try IP autoconf
if [ $ip_autoconf ]; then
    dev=egiga0
    _ip=$(ifconfig $dev | awk '/inet addr/ {print substr($2,6)}')
    _mask=$(ifconfig $dev | awk '/inet add/ {print substr($4,6)}')
    _bcast=$(ifconfig $dev | awk '/inet addr/ {print substr($3,7)}')
    _gw=$(route -n | awk '$1 == "0.0.0.0" {print $2}')
    _dev=eth0
    # it's eth0 in 2.6.25, egiga0 in 2.6.12
    if echo $kernel | grep -q '2.6.12'; then
	_dev=egiga0
    fi
    ip_cmdline="ip=$_ip::$_gw:$_mask:$(hostname):$_dev:none"
    cmdline="$cmdline $ip_cmdline"
fi    

cd /ffp/boot

# check for reloaded module
KV=$(uname -r)
test -r "reloaded-$KV.ko" || die "reloaded-$KV.ko: No compatible 'reloaded' module not found for this kernel"

# check for kernel image
test -r "$kernel" || die "$kernel: Kernel not found"

# check for initrd
if [ -n "$initrd" ]; then
    test -r "$initrd" || die "$initrd: Initrd not found"
fi

# create boot script
cat >/tmp/reload-script.sh<<EOF
set -x
/ffp/etc/rc stop

# clean up the rest
killall5 -15
sleep 5
killall5 -9

# filesystems
sync
swapoff -a
umount -a -r
sync
sleep 2

# boot
insmod reloaded-$KV.ko machtype=$machtype kernel=$kernel initrd=$initrd cmdline=\"$cmdline\"
echo "Failed!"
EOF

# go
echo "kernel=$kernel"
echo "initrd=$initrd"
echo "machtype=$machtype"
echo "cmdline=$cmdline$cmdline2"
echo
echo "Booting in 3 seconds. Please Ctrl-C to abort..."
sleep 3

nohup /ffp/bin/sh /tmp/reload-script.sh >/dev/console 2>&1 </dev/null
