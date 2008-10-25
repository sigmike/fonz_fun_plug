
SLIMSERVER_USER=nobody
SLIMSERVER_GROUP=0

mkdir -p $D$CPREFIX/lib/$PN
cp -r * $D$CPREFIX/lib/$PN

install -o $SLIMSERVER_USER -g $SLIMSERVER_GROUP -m 0755 -d \
    $D$CSYSCONFDIR/$PN \
    $D$CPREFIX/lib/$PN/Cache \
    $D$CPREFIX/lib/$PN/Logs \
    $D$CPREFIX/lib/$PN/prefs

mkdir -p $D$CPREFIX/sbin
install -o root -g root -m 0755 \
	$X/reset-slimserver-database.sh \
	$D$CPREFIX/sbin

#( cd $D$CPREFIX/lib/$PN/Logs; touch perfmon.log server.log; chown slimserver:slimserver * )
#install -o slimserver -g slimserver -m 0644 $X/files/* $D$CSYSCONFDIR/$PN/
#install -o slimserver -g slimserver -m 0755 -d $D$CSYSCONFDIR/$PN/plugin





