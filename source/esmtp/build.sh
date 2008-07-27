install_doc AUTHORS COPYING NEWS README TODO

./configure \
	--sysconfdir=/etc
make
make DESTDIR=$D install

