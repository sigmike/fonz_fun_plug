mkdir $D$CPREFIX
cd $D$CPREFIX

tar cf - -C $FILESDIR \
	--exclude=\*~ --exclude=.svn \
	etc sbin | tar xf -

# ensure correct permissions
chown -R root:root *

