    # fix MANDIR
    sed -i.bak "/^MANDIR/ s@=.*@=$CPREFIX/share/man@" Makefile.org

