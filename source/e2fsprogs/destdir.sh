    install -m 0755 -d $D$CPREFIX/etc
    make DESTDIR=$D install
    make DESTDIR=$D install-libs
    rm -rf $D/etc

    # we don't want hard links in the core packages
    cd $D$CPREFIX/sbin
    rm -f e2label findfs
    ln -s tune2fs e2label
    ln -s tune2fs findfs
    rm -f fsck.ext2 fsck.ext3
    #ln -s e2fsck fsck.ext2
    #ln -s e2fsck fsck.ext3
    rm -f mkfs.ext2 mkfs.ext3
    #ln -s mke2fs mkfs.ext2
    #ln -s mke2fs mkfs.ext3

    # Note that a few hard links remain in share/man
    # but we don't include man pages in fun_plug.tgz

