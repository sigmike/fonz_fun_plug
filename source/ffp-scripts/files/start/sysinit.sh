#!/ffp/bin/sh

# PROVIDE: sysinit

. /ffp/etc/ffp.subr

name="sysinit"
start_cmd="sysinit_start"

sysinit_start()
{
    # fixup firmware issues

    # /dev/random
    if [ ! -e /dev/random ]; then
        mknod /dev/random c 1 8
    fi

    # /dev/ptmx
    if [ ! -e /dev/ptmx ]; then
        mknod -m 0666 /dev/ptmx c 5 2
    fi

    # /dev/pts
    if [ ! -d /dev/pts ]; then
        mkdir /dev/pts
    fi
    
    # devpts mount
    mount | grep devpts 1>/dev/null 2>/dev/null \
        || mount -t devpts devpts /dev/pts

    # writable /dev/null
    chmod a+w /dev/null
}

run_rc_command "$1"

