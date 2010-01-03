
sed -i "s,/ffp/man/,/ffp/share/man/,g" parcels/*/install-*

make DESTDIR=$D install-backup-client
make DESTDIR=$D install-backup-server


