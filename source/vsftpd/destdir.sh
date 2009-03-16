mkdir -p $D$CPREFIX/sbin 
install -o root -g root -m 0755 vsftpd $D$CPREFIX/sbin

mkdir -p $D$CPREFIX/share/man/man5 $D$CPREFIX/share/man/man8
install -o root -g root -m 0644 vsftpd.conf.5 $D$CPREFIX/share/man/man5
install -o root -g root -m 0644 vsftpd.8 $D$CPREFIX/share/man/man8

mkdir -p $D$CPREFIX/etc/examples
install -o root -g root -m 0644 vsftpd.conf $D$CPREFIX/etc/examples

