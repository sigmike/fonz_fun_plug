    # change the default location of the vimrc configuration file
    echo "#define SYS_VIMRC_FILE \"$CSYSCONFDIR/vimrc\"" >>src/feature.h

    # fix MANDIR, uncommented by vim-7.1-mandir-1.patch
    sed -i \
        -e "/^MANDIR/ s@/usr/@$CPREFIX/@" \
        src/Makefile

