
# install/doinst.sh
if [ -r $X/doinst.sh ]; then
	mkdir -p $D/install
	install -o root -g root -m 0644 $X/doinst.sh $D/install/
fi


