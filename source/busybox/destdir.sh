make install

# create a script that can (re-)create all busybox links
# at runtime, using relative paths (not absolute, as
# busybox --install does).
$X/make-busybox-links.sh

# now, remove all the links from the package
cd $D
find -type l | xargs rm

