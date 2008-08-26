
sed -i \
	-e "s@/etc/login.defs@$CPREFIX&@" \
	$(grep -rl /etc/login.defs *)

sed -i \
	-e "/HUP_MESG_FILE/ s@/etc/@$CPREFIX&@" \
	src/logoutd.c

sed -i \
	-e "/TABLE/ s@/etc/@$CPREFIX&@" \
	src/login_nopam.c

sed -i \
	-e "/SUAUTHFILE/ s@/etc/@$CPREFIX&@" \
	src/suauth.c

sed -i \
	-e "/SKEL_DIR/           s@/etc/@$CPREFIX&@" \
	-e "/USER_DEFAULTS_FILE/ s@/etc/@$CPREFIX&@" \
	-e "/NEW_USER_FILE/      s@/etc/@$CPREFIX&@" \
	src/useradd.c

sed -i \
	-e "/LIMITS_FILE/ s@/etc/@$CPREFIX&@" \
	libmisc/limits.c

