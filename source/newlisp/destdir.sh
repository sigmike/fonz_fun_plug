
mkdir -p $D$CPREFIX/bin
mkdir -p $D$CPREFIX/share/man/man1

make DESTDIR=$D install

