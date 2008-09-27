
sed -i "/linux/ s@-shared@& ${LDFLAGS}@" Configure

./configure.gnu \
    --prefix=$CPREFIX \
    -Dvendorprefix=$CPREFIX \
    -Dman1dir=$CPREFIX/share/man/man1 \
    -Dman3dir=$CPREFIX/share/man/man3 \
    -Dpager="$CPREFIX/bin/less -isR" \
    -Dusethreads \
    -Dextras="$(echo $(cat $X/extras))" \


