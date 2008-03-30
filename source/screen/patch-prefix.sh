    sed -i \
        -e "s@/bin/sh@${CPREFIX}&@g" \
        fileio.c window.c Makefile.in
    sed -i \
        -e "/^static char DefaultPath/ s@=.*@= \":$CPREFIX/bin:/usr/bin:/bin\";@" \
        window.c

