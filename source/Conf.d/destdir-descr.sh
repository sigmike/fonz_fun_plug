
# install/DESCR
if [ -r $X/DESCR ]; then
	mkdir -p $D/install
	install -o root -g root -m 0644 $X/DESCR $D/install/
fi


