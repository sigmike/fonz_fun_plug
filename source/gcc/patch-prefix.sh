    # update dynamic-linker path
    sed -i \
        -e "s@/lib/ld@$CPREFIX&@" \
        $(find gcc/config/$CARCH -name \*.h)

    # update STARTFILE_PREFIX_SPEC
    echo "

#undef STARTFILE_PREFIX_SPEC
#define STARTFILE_PREFIX_SPEC \"$CPREFIX/lib/\"

" >>gcc/config/linux.h

    # update include search paths
    echo "

#undef STANDARD_INCLUDE_DIR
#define STANDARD_INCLUDE_DIR 0

" >>gcc/config/linux.h

# update NATIVE_SYSTEM_HEADER_DIR
sed -i \
	-e "/^NATIVE_SYSTEM_HEADER_DIR/ s@/usr/@$CPREFIX/@" \
	gcc/Makefile.in


# add RPATH to SHLIB_LINK command
sed -i "/SHLIB_LINK =/ s@-nodefaultlibs@& ${LDFLAGS_RPATH}@" \
	gcc/config/t-* gcc/config/*/t-*

#export BUILD_LDFLAGS="${LDFLAGS}"
#export LDFLAGS_FOR_BUILD="${LDFLAGS}"
#export LDFLAGS_FOR_TARGET="${LDFLAGS}"
#export LD_LIBRARY_PATH="$CPREFIX/lib"

