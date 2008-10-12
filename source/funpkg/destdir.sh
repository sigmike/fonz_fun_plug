tar cf - --owner=root --group=root -C $FILESDIR --exclude=\*~ --exclude=.svn ffp | tar xf - -C $D

cd $D$CPREFIX
mkdir -p tmp
mkdir -p var/packages

