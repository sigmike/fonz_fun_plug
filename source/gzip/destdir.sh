    make DESTDIR=$D install

    # we don't want hard links in the core packages
    cd $D$CPREFIX/bin
    rm -f uncompress
    ln -s gunzip uncompress

