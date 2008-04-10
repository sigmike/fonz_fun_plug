mkdir -p $D$CPREFIX/etc/examples
cd $X/etc/examples
install -m 0644 -o root -g root \
	lighttpd.conf lighttpd.conf-with-php \
	$D$CPREFIX/etc/examples

