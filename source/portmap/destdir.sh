    install -m 0755 -d $D$CPREFIX/sbin
    install -m 0755    pmap_dump pmap_set $D$CPREFIX/sbin
    install -m 0755    portmap $D$CPREFIX/sbin/rpc.portmap

    install -m 0755 -d $D$CPREFIX/share/man8
    install -m 0644    portmap.man $D$CPREFIX/share/man8/pmap_dump.8
    install -m 0644    portmap.8 pmap_set.8 $D$CPREFIX/share/man8

