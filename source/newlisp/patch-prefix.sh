
# this is for make DESTDIR
sed -i \
	-e "s@/usr/@${CPREFIX}/@" Makefile


# this is the rest
sed -i \
	-e "s@/usr@${CPREFIX}@g" \
	$(find -type f)

