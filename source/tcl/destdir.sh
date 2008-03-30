    make DESTDIR=$D install
    make DESTDIR=$D install-private-headers
    ln -s tclsh8.4 $CPREFIX/bin/tclsh

