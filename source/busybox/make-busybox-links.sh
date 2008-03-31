#!/bin/sh
#set -x

cd $D$CPREFIX

busybox=$(find -name busybox)
echo "busybox: $busybox"

bindir=$(dirname $busybox)
echo "bindir:  $bindir"

f=$bindir/install-busybox-links.sh
echo "script:  $f"

cat >$f <<EOF
#!$CPREFIX/bin/sh
set -x
cd .$CPREFIX || cd $CPREFIX || exit 1
mkdir -p bin sbin

EOF

find . -type l -printf "ln -s \$1 '%l' '%P' 2>/dev/null\n" >>$f
 
chmod a+x $f



