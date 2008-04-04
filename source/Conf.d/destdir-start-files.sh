
# check for start-*.sh files
for start_file in $(find $X -name start-\*.sh); do
	mkdir -p $D/ffp/start
	dest_file=$(basename $start_file | sed 's@start-@@')
	install -m 0644 -o root -g root $start_file $D/ffp/start/$dest_file
done


