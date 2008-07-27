sed -i \
	-e "s@^#!.*@#!${CPREFIX}/bin/sh@" \
	-e "/^PATH=/   s@=@=${CPREFIX}/bin:@" \
	-e "/^SHELL=/  s@=@=${CPREFIX}@" \
	src/mailstat

