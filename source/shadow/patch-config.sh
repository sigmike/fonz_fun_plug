
cp etc/login.defs etc/login.defs.orig

# use /ffp/var/mail for mail
sed -i "s@/var/spool/mail@$CPREFIX/var/mail@" etc/login.defs

# read motd from /ffp/etc/motd
sed -i "/MOTD/ s@/etc@$CSYSCONFDIR@" etc/login.defs

# don't use securetty by default
sed -i 's@^CONSOLE@# &@' etc/login.defs

# move environ file to /ffp/etc
sed -i "/^ENVIRON_FILE/ s@/etc@$CSYSCONFDIR@" etc/login.defs

# defaults paths
sed -i \
	-e "/^ENV_SUPATH/ s@=@=$CPREFIX/sbin:$CPREFIX/bin:@" \
	-e "/^ENV_PATH/   s@=@=$CPREFIX/bin:@" \
	etc/login.defs


# no cracklib
sed -i "s@^CRACKLIB_DICTPATH@# &@" etc/login.defs

