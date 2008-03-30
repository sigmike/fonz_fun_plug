    mkdir -p $D$CPREFIX/include $D$CPREFIX/lib $D$CPREFIX/sbin
    mkdir -p $D$CPREFIX/share/man/man3 $D$CPREFIX/share/man/man5 $D$CPREFIX/share/man/man8
    make DESTDIR=$D install

