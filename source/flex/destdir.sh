    make DESTDIR=$D install

    # There are some packages that expect to find the lex library in
    # /usr/lib. Create a symlink to account for this:
    mkdir -p $D$CPREFIX/lib
    ln -sf libfl.a $D$CPREFIX/lib/libl.a

    # A few programs do not know about flex yet and try to run its
    # predecessor, lex. To support those programs, create a wrapper
    # script named lex that calls flex in lex emulation mode:
    mkdir -p $D$CPREFIX/bin
    cat > $D$CPREFIX/bin/lex <<EOF
#!/bin/sh
exec $CPREFIX/bin/flex -l "\$@"
EOF

chmod 755 $D$CPREFIX/bin/lex

