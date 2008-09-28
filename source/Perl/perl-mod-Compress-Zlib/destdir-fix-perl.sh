# Fix packlist files
cd $D
for f in $(find -name .packlist); do
	mv $f ${f}.orig
	cat ${f}.orig | grep "^$D" | sed -e "s@^$D@@" | sort >$f
	rm ${f}.orig
done

# Rename perllocal.pod files
for f in $(find -name perllocal.pod); do
	mv $f ${f}.new
done

