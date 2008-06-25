make docdir=$CPREFIX/share/doc/$P DESTDIR=$D install
cd $D$CPREFIX
chown -R root:root *
