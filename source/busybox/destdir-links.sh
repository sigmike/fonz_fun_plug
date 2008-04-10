# create a script that can (re-)create all busybox links
# at runtime, using relative paths (not absolute, as
# busybox --install does).

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

# now, remove all the links from the package
cd $D
find -type l | xargs rm


