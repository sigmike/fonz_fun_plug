    make PROGRAMS="$PROGS" DESTDIR=$D install
    install -m 0755 -d $D$CPREFIX/share/man/man{1,8}
    install -m 0644    dbclient.1 $D$CPREFIX/share/man/man1
    install -m 0644    dropbear.8 dropbearkey.8 $D$CPREFIX/share/man/man8

    # ssh link
    ln -s dbclient $D$CPREFIX/bin/ssh

