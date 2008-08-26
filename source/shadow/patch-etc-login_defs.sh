cp etc/login.defs etc/login.defs.orig

sed -i \
	-e "/MOTD_FILE/      s@/etc/@$CPREFIX&@" \
	-e "/ISSUE_FILE/     s@/etc/@$CPREFIX&@" \
	-e "/TTYTYPE_FILE/   s@/etc/@$CPREFIX&@" \
	-e "/HUSHLOGIN_FILE/ s@/etc/@$CPREFIX&@" \
	-e "/ENV_SUPATH/     s@=@=$CPREFIX/sbin:$CPREFIX/bin:@" \
	-e "/ENV_PATH/       s@=@=$CPREFIX/bin:@" \
	-e "/ENVIRON_FILE/   s@/etc/@$CPREFIX&@" \
	-e "/USERDEL_CMD/    s@/usr/@$CPREFIX/@" \
	etc/login.defs

sed -i \
	-e "s@^CONSOLE@# &@" \
	-e "s@^CRACKLIB_DICTPATH@# &@" \
	etc/login.defs

