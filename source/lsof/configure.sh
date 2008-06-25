./Configure -n linux

sed -i "/^CFGL/ s@\$@ ${LDFLAGS_RPATH}@" Makefile

