#!/bin/bash
#set -x

PV=0.5
PR=$(date '+%y%m%d')

die()
{
    echo "$@"
    exit 1
}

tarball="fun_plug.tgz"

CWD=$(pwd)

# set of packages to include in the tarball
plist=(
    uclibc
    ffp-scripts
    busybox
    dns323-utils
    e2fsprogs
    file
    rcorder
    rsync
    strace
)

# set of packages from which to install libraries
lplist=(
    gcc
    libiconv
    ncurses
    readline
    zlib
)

# where are the package files?
PKGDIR=$CWD/packages
[ -d "$PKGDIR" ] || die "packages directory not found"

# where's the find-packages.sh script?
SCRIPTSDIR=$CWD/scripts
[ -d "$SCRIPTSDIR" ] || die "scripts directory not found"
[ -x "$SCRIPTSDIR/find-packages.sh" ] || die "$SCRIPTSDIR/find-packages.sh: Script not found (or not executable)"

# create list of package files
pkg_files=$($SCRIPTSDIR/find-packages.sh $PKGDIR ${plist[*]})
[ -n "$pkg_files" ] || die "Packages not found"
echo "$pkg_files" | grep MISSING >/dev/null
[ $? -eq 0 ] && die "Did not find all packages: ${plist[*]}"

# create list of lib packages files
lib_pkg_files=$($SCRIPTSDIR/find-packages.sh $PKGDIR ${lplist[*]})
[ -n "$lib_pkg_files" ] || die "Library packages not found"
echo "$lib_pkg_files" | grep MISSING >/dev/null
[ $? -eq 0 ] && die "Did not find all library packages: ${lplist[*]}"

# use tar-1.13 if available (for compatibility with the pre 1.0 busybox)
TAR=tar-1.13
which $TAR >/dev/null 2>&1 || TAR=tar
echo "tar program:    $TAR"

# work dir
WORKDIR=$CWD/work
D=$WORKDIR/fun_plug
echo "Work directory: $D"
rm -rf $D && mkdir -p $D || exit 1

# hard-coded prefix
CPREFIX=/ffp
echo "Prefix: $CPREFIX"

# install packages
for f in $pkg_files; do
    echo "  Installing $(basename $f) ... "
    tar xf $f -C $D
done

# install libraries
for f in $lib_pkg_files; do
    echo "  Installing libraries from $(basename $f) ..."
    libs=$(tar tzf $f | egrep '/lib.*\.so')
    tar xf $f -C $D $libs
done

# check prefix
if [ $(cd $D; ls | wc -l) -ne 1 ]; then
    echo "ERROR: Too many files/directories in target root:"
    ( cd $D; ls -1 )
    exit 1
fi

# clean devel files
echo "  Removing devel files ..."
rm -rf $D/*/include
rm -f  $D/*/lib/*.{la,a,o}

# clean misc files
echo "  Removing misc files ..."
rm -rf $D/*/share/*

# create package database
mkdir -p $D$CPREFIX/var/packages
( cd $D; find .$CPREFIX ) \
    | grep -v "^\.$CPREFIX/var/packages/" \
    >$D$CPREFIX/var/packages/fun_plug-$PV-$PR

# check for remaining hard links
( cd $D; find -type f -printf "%-5n %-15i %p\n" ) | \
    awk '$1 > 1 { print $0 }' | sort -nk2 >$WORKDIR/hard-links.txt
if [ $(wc -l $WORKDIR/hard-links.txt | cut -f1 -d' ') -gt 0 ]; then
    echo "Hard links found. See $WORKDIR/hard-links.txt"
    exit 1
fi

# create tarball
echo "  Creating $tarball ..."
$TAR cf - -C $D$CPREFIX . | gzip -c -9 >$tarball
du -k $tarball

# done
echo "  OK"

