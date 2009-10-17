#!/ffp/bin/sh

dirl="$@"

find \( -name \*.pm -o -name \*.so \) -printf "%P\n" | while read f; do
    #echo $f
    for d in $dirl; do
	if [ -r "$d/$f" ]; then
	    echo "rm -vf $f"
	    #echo "  Found $f and $d/$f"
	fi
    done
done

    







