
# manually fix flags for shared objects
#sed -i \
#	-e "/^SHARED_LDFLAGS=/ s@=@=${LDFLAGS}@" \
#	-e "/^LDFLAGS=/ s@=@=${LDFLAGS}@" \
#	Makefile*

sed -i "/^my \$shared_ldflag =/ s@=.*@= \"$LDFLAGS\";@" Configure
