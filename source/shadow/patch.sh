
# disable groups program and man page
# they say coreutils provides a better version
sed -i 's/groups$(EXEEXT)//' src/Makefile.in
sed -i -e 's/groups.1 //' -e '/groups.1.xml/d' $(find man -name Makefile\*)

# disable su, it doesn't work with busybox sh
sed -i 's/su$(EXEEXT)//' src/Makefile.in
sed -i '/^suidbins/ s@ su@@' src/Makefile.in
sed -i \
	-e 's/su.1//' -e '/su.1.xml/d' \
	-e 's/suauth.1//' -e '/suauth.1.xml/d' \
	$(find man -name Makefile\*)

