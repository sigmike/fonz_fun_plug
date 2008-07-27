sed -i \
	-e "/DEFsendmail/ s@^/\*@@" \
	-e "/DEFsendmail/ s@/usr/sbin@${CPREFIX}/bin@" \
	-e "/BinSh/ s@/bin/sh@${CPREFIX}&@" \
	-e "/DEAD_LETTER/ s@/tmp@${CPREFIX}&@" \
	-e "s@/etc@${CSYSCONFDIR}@" \
	config.h

echo "LDFLAGS=$LDFLAGS"
sed -i \
	-e "/^LDFLAGS0/ s@\$@ ${LDFLAGS}@" \
	Makefile

