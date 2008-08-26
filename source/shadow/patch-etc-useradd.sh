cp etc/useradd etc/useradd.orig

sed -i \
	-e "/^SHELL=/ s@=.*@=${CPREFIX}/bin/sh@" \
	-e "/^SKEL=/  s@=.*@=${CPREFIX}/etc/skel@" \
	-e "/^CREATE_MAIL_SPOOL=/ s@yes@no@" \
	etc/useradd

