tar cf - --owner=root --group=root -C $FILESDIR --exclude=\*~ --exclude=.svn ffp | tar xf - -C $D

mkdir -p $D$CPREFIX/etc/profile.d

