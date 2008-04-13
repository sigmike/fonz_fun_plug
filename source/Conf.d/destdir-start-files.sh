
# check for start-*.sh files
for start_file in $(find $X -name start-\*.sh); do
	mkdir -p $D/ffp/start
	dest_file=$(basename $start_file | sed 's@start-@@')
	rm -f $D/ffp/start/$dest_file
	cp $start_file $D/ffp/start/$dest_file
	chown root:root $D/ffp/start/$dest_file
done


