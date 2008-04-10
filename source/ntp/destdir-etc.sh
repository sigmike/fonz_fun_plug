mkdir -p $D$CPREFIX/etc/examples
cd $X/etc/examples
install -m 0644 -o root -g root \
	ntp.conf \
	$D$CPREFIX/etc/examples

