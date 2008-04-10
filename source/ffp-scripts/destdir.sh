        mkdir $D$CPREFIX
        cd $D$CPREFIX

        mkdir -p etc
        #cp -ar $FILESDIR/examples etc/
        install -m 0644 $FILESDIR/ffp.subr etc/
        install -m 0755 $FILESDIR/rc etc/

        install -m 0644 $FILESDIR/profile etc/

        mkdir -p start/
        install -m 0644 $FILESDIR/start/*.sh start/
        chmod a+x start/{sysinit,telnetd}.sh

        mkdir -p sbin
        install -m 0755 $FILESDIR/funpkg sbin/

	chown -R root:root *

	# clean up unwanted stuff
	find -name .svn -type d | xargs rm -rf

