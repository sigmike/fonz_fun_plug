make INSTALL_ROOT=$D install

# install php.ini examples
mkdir -p $D$CPREFIX/etc/examples
install -m 0644 -o root -g root $S/php.ini-* $D$CPREFIX/etc/examples

# php sucks
cd $D
rm -rf .registry .channels .filemap .lock .depdblock .depdb

