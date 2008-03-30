# check for broken libs
find . -type f -name \*.so\* | while read f; do
    # check for non-PIC libs
    if readelf -a $f | grep R_ARM_PC24 >/dev/null 2>&1; then
        die "$f: Found R_ARM_PC24"
    fi
    # check for bad RPATH
    if readelf -d $f | grep RPATH | grep $WORKDIR >/dev/null 2>&1; then
        die "$f: Found bad RPATH: $(readelf -d $f | grep RPATH)"
    fi
done

