mkdir -p $D$CPREFIX/var/log/samba/

mkdir -p $D$CPREFIX/etc/examples
cd $X/examples
install -o root -g root -m 0644 smb.conf inetd.conf-swat $D$CPREFIX/etc/examples/

