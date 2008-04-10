#!/ffp/bin/sh

# PROVIDE: unfsd
# REQUIRE: SERVERS portmap

. /ffp/etc/ffp.subr

name="unfsd"
start_cmd="unfsd_start"
stop_cmd="unfsd_stop"
status_cmd="unfsd_status"

unfsd_start() {
    exports=/ffp/etc/exports

    if test ! -f $exports; then
        echo "Creating default exports file..."
        ip=$(ifconfig egiga0 | awk '/inet addr/ { print substr($2, 6) }')
        cnet=$(echo $ip | cut -d. -f1-3).0/24
        options="rw,no_root_squash"

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

    unfsd_flags="-e ${exports}"

    proc_start /ffp/sbin/rpc.portmap
    proc_start /ffp/sbin/unfsd
}

unfsd_stop() {
    proc_stop unfsd
    proc_stop rpc.portmap
}

unfsd_status() {
    proc_status unfsd
    proc_status rpc.portmap
}

run_rc_command "$1"

