    make DESTDIR=$D install

    # we don't want hard links in the core packages.
    cd $D$CPREFIX/bin
    rm -f gawk-$PV pgawk-$PV

