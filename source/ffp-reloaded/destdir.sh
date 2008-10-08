tar cf - -C $X/files --exclude=.svn --exclude=*~ --owner=root --group=root . | tar xf - -C $D

