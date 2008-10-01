
sed -i \
	-e "/-o newlisp\$/ s@\$@ ${LDFLAGS}@" \
	makefile_linux*

