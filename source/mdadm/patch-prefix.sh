sed -i \
	-e "s@/usr/bin/@@" \
	-e "/^SYSCONFDIR/ s@/etc@${CPREFIX}&@ " \
	-e "/^BINDIR/ s@/sbin@${CPREFIX}&@" \
	-e "/^MANDIR/ s@/usr@${CPREFIX}@" \
	-e "/^MAILCMD/ s@/usr/sbin@${CPREFIX}/bin@" \
	Makefile

