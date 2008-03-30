#!/ffp/bin/sh

# PROVIDES: statd nfsd mountd
# BEFORE: LOGIN
# REQUIRE: SERVERS portmap

. /ffp/etc/ffp.subr

name="nfsd"
rpc_nfsd_flags="8"
start_cmd="nfsd_start"
stop_cmd="nfsd_stop"
status_cmd="nfsd_status"

nfsd_start()
{
    exports=/ffp/etc/exports

    if test ! -f $exports; then
        echo "Creating default exports file..."
        ip=$(ifconfig egiga0 | awk '/inet addr/ { print substr($2, 6) }')
        cnet=$(echo $ip | cut -d. -f1-3).0/24
        options="rw,no_root_squash,no_subtree_check"
        
        for f in /mnt/*; do
            if test -d $f; then
                echo "$f $cnet($options)" >>$exports
            fi
        done
        cat $exports
    fi

    if [ ! -e /etc/exports ]; then
        echo "Linking /etc/exports ..."
        ln -s $exports /etc/exports
    fi

    if [ ! -d /var/lib/nfs ]; then
        mkdir -p /var/lib/nfs
        mkdir -p /var/lib/nfs/sm.bak
        mkdir -p /var/lib/nfs/sm
        mkdir -p /var/log/nfsd
        touch /var/lib/nfs/rmtab
    fi

    proc_start /ffp/sbin/rpc.portmap
    proc_start /ffp/sbin/rpc.statd
    exportfs -r
    proc_start /ffp/sbin/rpc.nfsd
    proc_start /ffp/sbin/rpc.mountd
}

nfsd_stop()
{
    proc_stop rpc.mountd
    killall nfsd
    sleep 1
    killall -9 nfsd
    sleep 1
    proc_stop rpc.statd
    proc_stop rpc.portmap
}

nfsd_status()
{
    proc_status rpc.portmap
    proc_status rpc.statd
    proc_status nfsd
    proc_status rpc.mountd
}

run_rc_command "$1"
