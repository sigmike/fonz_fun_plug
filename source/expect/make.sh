# fix Makefile, remove unwanted rpath entries
sed -i \
	-e '/^EXP_AND_TCL_LIBS/ s@-Wl,-rpath[^ ]*@@' \
	-e '/^EXP_AND_TK_LIBS/  s@-Wl,-rpath[^ ]*@@' \
	Makefile

make

