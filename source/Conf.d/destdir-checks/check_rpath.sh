find -type f | while read f; do
    if file $f | grep ELF >/dev/null; then
        _rpath=$(readelf -d $f | grep RPATH)
	if ! echo "$_rpath" | egrep "[:[]$CPREFIX/lib[]:]" >/dev/null; then
		die "$f: Missing RPATH"
	fi
	if echo "$_rpath" | grep "$WORKDIR" >/dev/null; then
		die "$f: RPATH contains WORKDIR"
	fi
    fi
done

        
