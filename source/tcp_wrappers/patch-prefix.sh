    # adjust prefix
    sed -i.bak \
        -e "/DESTDIR/ s,/usr/,$CPREFIX/," \
        Makefile

