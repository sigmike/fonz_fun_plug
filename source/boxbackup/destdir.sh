
sed -i "s,/ffp/man/,/ffp/share/man/,g" parcels/*/install-*

mkdir -p $D/ffp/bin
make DESTDIR=$D install-backup-client
make DESTDIR=$D install-backup-server


