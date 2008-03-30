find . -type f -name \*.la | while read f; do
	# remove all -L$WORKDIR blocks
	sed -i "/^dependency_libs=/ s@ -L$WORKDIR[^' ]*@@g" $f
done

