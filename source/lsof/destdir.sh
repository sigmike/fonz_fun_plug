mkdir -p $D$CPREFIX/bin
install -m 0755 -o root -g root lsof $D$CPREFIX/bin

mkdir -p $D$CPREFIX/share/man/man8
install -m 0644 -o root -g root lsof.8 $D$CPREFIX/share/man/man8

