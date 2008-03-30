    # First, a sed substitution is needed to modify configure's
    # default search path for executables. It cycles through the
    # values in PREPATH until it finds the program it is looking
    # for. The -R switch is also added to the PAGER variable so that
    # escape sequences are properly handled by Less:
    cp configure{,.orig}
    sed -e "/PREPATH=/s@=.*@=\"$(eval echo $CPREFIX/{bin,sbin})\"@g" \
        -e 's@-is@&R@g' configure.orig >configure

    # Another couple of sed substitutions comment out the MANPATH
    # /usr/man and MANPATH /usr/local/man lines in the man.conf file
    # to prevent redundant results when using programs such as whatis:
    cp src/man.conf.in{,.orig}
    sed -e 's@MANPATH./usr/man@#&@g' \
        -e 's@MANPATH./usr/local/man@#&@g' \
        src/man.conf.in.orig >src/man.conf.in

    # won't ever use X11 on the dns323
    sed -i.bak \
        -e "/^MANPATH/ s@/usr/X11R6/@$CPREFIX/share/@" \
        src/man.conf.in

    # fix bindir in man2html
    sed -i.bak "s@/usr/@$CPREFIX/@" man2html/Makefile.in

