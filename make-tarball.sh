#!/bin/bash
set -e

CWD=$(pwd)
PKGDIR=$CWD/packages
WORKDIR=$CWD/work/fun_plug
D=$WORKDIR/sysroot
CPREFIX=/ffp
FUNPKG=$CWD/source/funpkg/files/ffp/sbin/funpkg
TAR=tar-1.13

# helper functions

die()
{
    cat <<EOF
FATAL: $@
EOF
    exit 1
}

find_pkg()
{
    _pkg=$(cd $PKGDIR; ls -1 $1-*.tgz | tail -n 1)
    [ -r "$PKGDIR/$_pkg" ] || die "$1: No package found"
    echo "$PKGDIR/$_pkg"
}

unpack_pkg()
{
    _pkg="$1"
    shift 1
    _cmd="tar xzf $_pkg -C $D $@"
    echo $_cmd
    eval $_cmd
}

install_pkg()
{
    _cmd="/bin/sh $FUNPKG -D $D -i $1"
    echo $_cmd
    eval $_cmd
}

list_libs()
{
    tar tzf $1 | egrep '/lib/lib.*\.so'
}

list_terminfo()
{
    _filter=
    while [ $# -gt 0 ]; do
        _filter="$_filter| egrep '/share/termifo/.*/$1\$'"
        shift 1
    done
    tar tzf $1 $_filter
}
    

# Checks
[ -x "$FUNPKG" ] || die "funpkg not found"
[ -d "$PKGDIR" ] || die "packages directory not found"
which $TAR >/dev/null 2>/dev/null || die "$TAR not found"


# Cleanup
echo "clean..."
rm -rf $WORKDIR
mkdir -p $WORKDIR $D


# busybox and links
echo "busybox..."
cd $D
tar xzf $(find_pkg busybox)
/bin/sh .$CPREFIX/bin/install-busybox-links.sh


# stripped program packages and core libs

plist=(
    uclibc
    e2fsprogs
    file
    libiconv
    ncurses
    sqlite
)

for p in ${plist[*]}; do
    pkg=$(find_pkg $p)
    unpack_pkg $pkg \
        --exclude=.$CPREFIX/include \
        --exclude=.$CPREFIX/lib/pkgconfig \
        --exclude=\*.la --exclude=\*.a --exclude=\*.o \
        --exclude=.$CPREFIX/lib/preloadable_\*
done

plist=(
    expat
    gcc
    libusb
    libxml2
    openssl
    pcre
    readline
    tcp_wrappers
    zlib
)
 
for p in ${plist[*]}; do
    pkg=$(find_pkg $p)
    list_libs $pkg | unpack_pkg $pkg -T -
done

cd $D
find .$CPREFIX >$WORKDIR/fun_plug.list
mkdir -p $D$CPREFIX/var/packages
mv $WORKDIR/fun_plug.list $D$CPREFIX/var/packages/fun_plug-0.5-$(date '+%y_%m_%d')



# pre-installed packages

plist=(
    busybox
    dialog
    dns323-utils
    ffp-scripts
    funpkg
    groff
    less
    lighttpd
    lsof
    man
    mediatomb
    nfs-utils
    ntp
    openssh
    portmap
    rcorder
    rsync
    shadow
    strace
    unfs3
    usbutils
    #vim
)

for p in ${plist[*]}; do
    pkg=$(find_pkg $p)
    install_pkg $pkg
done
    


# tarball

echo "fun_plug.tgz ..."
$TAR cf - -C $D$CPREFIX --owner=root --group=root . | gzip -9 -c >$CWD/fun_plug.tgz
du -k $CWD/fun_plug.tgz


