
sed -i "/linux/ s@-shared@& ${LDFLAGS}@" Configure

CC=gcc ./configure.gnu \
        --prefix=$CPREFIX \
        -Dman1dir=$CPREFIX/share/man/man1 \
        -Dman3dir=$CPREFIX/share/man/man3 \
        -Dpager="$CPREFIX/bin/less -isR" \
        -Dusethreads \

