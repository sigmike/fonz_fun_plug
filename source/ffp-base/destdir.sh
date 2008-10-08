
find_pkg()
{   
    _pkg=$(cd $PKGDIR; ls -1 $1-*.tgz | egrep "$1"'-[^-]*-[^-]*.tgz$' | tail -n 1)
    [ -r "$PKGDIR/$_pkg" ] || die "$1: No package found"
    echo "$PKGDIR/$_pkg"
}

unpack_pkg()
{   
    _pkg="$1"
    shift 1
    _cmd="tar xzvf $_pkg -C $D $@"
    echo $_cmd
    eval $_cmd
}

list_libs()
{   
    tar tzf $1 | egrep '/lib/lib.*\.so'
}

# set 1
for p in $(cat $X/set1); do
	pkg=$(find_pkg $p)
	info "    Installing $pkg ..." 
	unpack_pkg $pkg \
		--exclude=.$CPREFIX/include \
		--exclude=.$CPREFIX/lib/pkgconfig \
		--exclude=\*.la --exclude=\*.a --exclude=\*.o \
		--exclude=.$CPREFIX/lib/preloadable_\*
done

# set 2
for p in $(cat $X/set2); do
	pkg=$(find_pkg $p)
	info "    Installing $pkg ..."
	list_libs $pkg | unpack_pkg $pkg -T -
done

# busybox links
pkg=$(find_pkg busybox)
info "    Installing $pkg ..."
unpack_pkg $pkg
( cd $D; $CONFIG_SHELL .$CPREFIX/bin/install-busybox-links.sh )


