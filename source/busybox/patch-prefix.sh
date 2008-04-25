        # fix --install paths
        sed -i \
                -e "/const char/ s@/usr/@$CPREFIX/@" \
                -e 's@&usr_bin \[8\],@"",@' \
                -e 's@&usr_bin \[4\]@usr_bin@' \
                -e 's@&usr_sbin\[4\]@usr_sbin@' \
                libbb/appletlib.c

        # fix hardcoded paths
        #  include/libbb.h: LIBBB_DEFAULT_LOGIN_SHELL, DEFAULT_SHELL_SHORT_NAME
        sed -i \
                -e "/^#define LIBBB_DEFAULT_LOGIN_SHELL/ s@/bin/@$CPREFIX&@" \
                -e "/^#define DEFAULT_SHELL_SHORT_NAME/  s@6@sizeof(LIBBB_DEFAULT_LOGIN_SHELL)-3@" \
                include/libbb.h

        #  read profile file from $CPREFIX/etc/
        sed -i \
                -e "s@/etc/profile@$CPREFIX/etc/profile@" \
                shell/ash.c

        #  make login run $CPREFIX/bin/sh instead of /bin/sh
        sed -i \
                -e "/tmp = pw->pw_shell/ s@pw->pw_shell@\"$CPREFIX/bin/sh\"@" \
                loginutils/login.c

        # udhcpd.conf path
        sed -i \
                -e "/DHCPD_CONF_FILE/ s@/etc/udhcpd.conf@$CPREFIX&@" \
                networking/udhcp/dhcpd.h

        #  change BB_ADDITIONAL_PATH in libbb/messages.c
        sed -i \
                -e "/define BB_ADDITIONAL_PATH/ s@\"\"@\":$CPREFIX/bin:$CPREFIX/sbin\"@" \
                libbb/messages.c

# /etc/busybox.conf
# libbb/appletlib.c:static const char config_file[] ALIGN1 = "/etc/busybox.conf";
sed -i "/const char config_file/ s@/etc@$CSYSCONFDIR@" libbb/appletlib.c


