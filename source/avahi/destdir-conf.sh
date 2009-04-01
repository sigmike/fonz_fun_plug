cd $D/ffp/etc/avahi

# don't clobber config files
for f in $(find -type f); do
	mv $f $f.new
done

