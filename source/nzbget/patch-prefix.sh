sed -i \
	-e "/nzbget.conf/ s@/usr/local/etc@$CSYSCONFDIR@" \
	Options.cpp

