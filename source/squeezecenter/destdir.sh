
mkdir -p $D$CPREFIX/lib/$PN
cp -r * $D$CPREFIX/lib/$PN

install -o slimserver -g slimserver -m 0755 -d \
    $D$CSYSCONFDIR/$PN \
    $D$CPREFIX/lib/$PN/Cache \
    $D$CPREFIX/lib/$PN/Logs \
    $D$CPREFIX/lib/$PN/prefs

#( cd $D$CPREFIX/lib/$PN/Logs; touch perfmon.log server.log; chown slimserver:slimserver * )
#install -o slimserver -g slimserver -m 0644 $X/files/* $D$CSYSCONFDIR/$PN/
#install -o slimserver -g slimserver -m 0755 -d $D$CSYSCONFDIR/$PN/plugin




