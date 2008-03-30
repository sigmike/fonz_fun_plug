    #  dnsmasq.conf
    #  /var/...
    sed -i \
        -e "/CONFFILE/ s@CONFFILE.*@CONFFILE \"$CSYSCONFDIR/dnsmasq.conf\"@" \
        -e "s@/var/@$CPREFIX&@g" \
        src/config.h

