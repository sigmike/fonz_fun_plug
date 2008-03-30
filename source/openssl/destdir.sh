    mkdir -p $D$CSYSCONFDIR/ssl
    make INSTALL_PREFIX=$D install
    cp -r certs $D$CSYSCONFDIR/ssl

