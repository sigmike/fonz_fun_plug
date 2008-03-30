# $CPREFIX is expected in $D, and nothing else
if ! test -d ./$CPREFIX; then
    die "$CPREFIX not found in package directory $D"
fi
for _f in $(ls -a); do
    if test "$_f" = "." -o "$_f" = ".."; then
        continue
    fi
    if test "/$_f" != "$CPREFIX"; then
        die "$_f: Not allowed in package"
    fi
done

