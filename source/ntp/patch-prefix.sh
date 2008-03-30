    # fix ntp.conf path
    sed -i.bak "/CONFIG_FILE/ s@/etc/ntp.conf@$CPREFIX&@" \
        include/ntp_config.h ntpdate/ntptime_config.c

