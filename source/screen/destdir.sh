    make DESTDIR=$D install
    mkdir -p $D$CPREFIX/etc
    install -m 0644 etc/etcscreenrc $D$CPREFIX/etc/screenrc

