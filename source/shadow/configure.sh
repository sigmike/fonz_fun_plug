autoconf
autoheader
./configure \
    --sysconfdir=$CSYSCONFDIR \
    --enable-shared \
    --without-audit \
    --without-libpam \
    --without-selinux \
    --without-nscd

#    with_audit=no with_libpam=no with_selinux=no
