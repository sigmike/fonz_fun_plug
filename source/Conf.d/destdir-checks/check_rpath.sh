find -type f ! -name ld-\*.so | while read f; do
	if file $f | egrep 'ELF.*(executable|shared object)'  >/dev/null; then
		if ! _rpath=$(readelf -d $f | grep RPATH); then
			warn "$f: No RPATH"
			continue
		fi
		if ! echo "$_rpath" | egrep "[:[]$RPATH[]:]" >/dev/null; then
			warn "$f: RPATH does not contain $RPATH"
		fi
		if echo "$_rpath" | grep "$WORKDIR" >/dev/null; then
			warn "$f: RPATH contains WORKDIR"
		fi
    	fi
done

        
