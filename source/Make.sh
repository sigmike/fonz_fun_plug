#!/ffp/bin/bash


TOPDIR=$(cd ..; pwd)
CONFDIR=$(pwd)/Conf.d
DISTDIR=$TOPDIR/distfiles
PATCHDIR=$TOPDIR/patches
PKGDIR=$TOPDIR/packages
LOGDIR=$TOPDIR/build-logs



# print help and exit
usage()
{
    cat <<EOF
Usage: $(basename $0) [options] <directory>
Options:
	-F	Download distfiles and exit
	-T	Run testsuite
EOF
    exit 0
}

# exit on fatal error
die()
{
    cat >&3 <<EOF
FATAL: $@
EOF
    exit 1
}

# print warning
warn()
{
    cat >&3 <<EOF
WARNING: $@
EOF
}

# print message
info()
{
    cat >&3 <<EOF
$@
EOF
}

# die if a required directory is missing
check_required_dirs()
{
    for _d; do
        [ -d "$_d" ] || die "$_d: Required directory not found"
    done
}

# die if a required file is missing
check_required_files()
{
    for _f; do
        [ -r "$_f" ] || die "$_f: Required file not found"
    done
}

[ $# -eq 0 ] && usage
exec 3>&1 1>/dev/null


# defaults
unset F_opt		# fetch distfiles, don't compile
unset T_opt		# run testsuite

# parse options
_opts=$(getopt FT "$@")
eval set -- "$_opts"
while true; do
	case "$1" in
		-F)
			F_opt=1
			shift
			;;
		-T)
			T_opt=1
			shift
			;;
		--)
			shift
			break
			;;
		*)
			die "getopt error"
			;;
	esac
done
[ -d "$1" ] || usage


# check essential stuff
check_required_dirs $CONFDIR $PATCHDIR
check_required_dirs $1
check_required_files $1/PV
check_required_files $CONFDIR/makepkg.sh

# include config.in, if present
if [ -r "$CONFDIR/config.in" ]; then
	. $CONFDIR/config.in
fi


[ -r $1/PR ] || echo 1 >$1/PR
X=$(readlink -f $1)
PN=$(basename $1)
eval PV=$(cat $X/PV)
eval PR=$(cat $X/PR)
P=${PN}-${PV}
PF=${PN}-${PV}-${PR}

FILESDIR=$X/files

WORKDIR=$TOPDIR/work/$P
D=$WORKDIR/pkg


# distfiles
A=
# If present, we use SRC_URI to create the default list of
# source archives (A)
SRC_URI=
[ -r "$X/SRC_URI" ] && eval SRC_URI=\"$(cat $X/SRC_URI)\"
if [ -n "$SRC_URI" ]; then
	for _uri in $SRC_URI; do
		_f=$(basename $_uri)
		if [ -n "$F_opt" ]; then
			if [ ! -e "$DISTDIR/$_f" ]; then
				[ -x "$CONFDIR/fetch.sh" ] || die "$CONFDIR/fetch.sh: Not found or not excutable"
				info "* $_f: Fetch $_uri"
				$CONFDIR/fetch.sh -d "$DISTDIR" "$_uri" || die "Could not fetch $(basename $_f)"
			else
				info "* $_f: found"
			fi
		fi
		A="$A $_f"
	done
fi
# If A is present, this has prioriy
[ -r "$X/A" ] && eval A=\"$(cat $X/A)\"


# Exit here for -F
[ $F_opt ] && exit


info "* $PF"


# Source directory defaults to $P
S=$WORKDIR/$P
[ -r "$X/S" ] && eval S=$WORKDIR/$(cat $X/S)


# Build directory defaults to $S
B=$S
[ -r "$X/B" ] && eval B=$WORKDIR/$(cat $X/B)


# write a build log
mkdir -p $LOGDIR
exec 1>$LOGDIR/$PF.log 2>&1
echo $0 $@
set -xe


# W cleanup
rm -rf $WORKDIR
mkdir -p $WORKDIR


# include build-env/*.sh files
for _f in $(ls $CONFDIR/build-env/*.sh 2>/dev/null);  do
	. $_f
done


# use config.site, if present
if [ -r "$CONFDIR/config.site" ]; then
	info "  config.site found"
	export CONFIG_SITE=$CONFDIR/config.site
fi


# use /bin/bash
export CONFIG_SHELL=/bin/bash


# use wrappers
export PATH=$CONFDIR/wrappers:$PATH


# store temp files in workdir
export TMPDIR=$WORKDIR/tmp
export TEMPDIR=$TMPDIR
mkdir -p $TMPDIR


# U unpack
cd $WORKDIR

find_distfile()
{
	check_required_dirs $DISTDIR
	for _ext in .tar.bz2 .tar.gz .tgz .tar ""; do
		if [ -r "$DISTDIR/$1$_ext" ]; then
			echo "$DISTDIR/$1$_ext"
			break
		fi
	done
}

for _f in $A; do
	f=$(find_distfile "$_f")
	if [ -d "$f" ]; then
		info "  copy dir $(basename $f) ..."
		tar cf - -C $DISTDIR --exclude=.svn --exclude=.git --exclude=CVS $_f | tar xf -
	elif [ -r "$f" ]; then
		info "  unpack $(basename $f) ..."
		case "$f" in
			*.tar.bz2)
				tar xjf $f
				;;
			*.tar.gz | *.tgz)
				tar xzf $f
				;;
			*.tar)
				tar xf $f
				;;
			*)
				die "$(basename $f): Don't know how to unpack"
				;;
		esac
	else
		die "$_f: No archive found"
	fi
done

if [ -r $X/unpack.sh ]; then
	info "  unpack.sh ..."
	cd $WORKDIR
	. $X/unpack.sh
fi	

# check that we got $S directory
[ -n "$A" ] && check_required_dirs $S


# now make build and destdir directories
mkdir -p $B $D


# P patch
# apply patches listed in $X/patch-series
cat_prog()
{
    case "$1" in
        *.gz)
            echo zcat
            ;;
        *)
            echo cat
            ;;
    esac
}
    
if [ -r $X/patch-series ]; then
    info "  patch-series ..."
    cd $S
    _patch_series_cmd=$(cat $X/patch-series | while read _f _popt; do
            echo "$(cat_prog $_f) $PATCHDIR/$P/$_f | patch -N ${_popt:--p1}"
    done)
    eval "$_patch_series_cmd"
fi
# use config.guess and config.sub from $CONFDIR
cd $WORKDIR
for _f in $(find . -name config.sub -o -name config.guess); do
    info "  updating $_f ..."
    # keep old file, we need its timestamp
    mv $_f $_f.orig                     
    # create a new file (and don't symlink, since we want to touch it)
    cat $CONFDIR/$(basename $_f) >$_f
    chmod 0755 $_f 
    # keep modification time to prevent dependency issues (autoconf)
    # don't fail if touch doesn't support -r (busybox)
    touch -r $_f.orig $_f || true
done
# if present, run $X/patch*.sh
for _f in $(ls $X/patch*.sh 2>/dev/null); do
	info "  $(basename $_f) ..."
	cd $S
	. $_f
done


# C configure
configure_args=
[ -r $X/configure_args ] && \
    eval configure_args=\"$(cat $X/configure_args | sed 's@#.*@@')\"
if [ -r $X/configure.sh ]; then
	info "  configure.sh ..."
	cd $B
	. $X/configure.sh
elif [ -x $S/configure ]; then
	info "  configure ..."
	cd $B
	eval $S/configure $configure_args
fi

# M make
if [ -r $X/make.sh ]; then
	info "  make.sh ..."
	cd $B
	. $X/make.sh
elif [ -r $B/Makefile -o -r $B/makefile ]; then
	info "  make ..."
	cd $B
	make $make_args
fi

# T testsuite
if [ $T_opt ]; then
	if [ -r $X/testsuite.sh ]; then
		info "  testsuite.sh ..."
		cd $B
		. $X/testsuite.sh
	elif [ -r $B/Makefile ]; then
        	info "  make check ..."
        	cd $B
        	make -k check || true
    	fi
fi

# D destdir
if [ -r $X/destdir.sh ]; then
	info "  destdir.sh ..."
	cd $B
	. $X/destdir.sh
elif [ -r $B/Makefile -o -r $B/makefile ]; then
	info "  destdir ..."
	cd $B
	make DESTDIR=$D install
fi
# run additional destdir scripts
for _f in $(find $CONFDIR -name destdir-\*.sh); do
	if [ -x "$_f" ]; then
		info "  $(basename $_f)"
		cd $D
		. $_f
	fi
done
for _f in $(find $X -name destdir-\*.sh); do
	info "  $(basename $_f) ..."
	cd $B
	. $_f
done
# run scripts from config/destdir-checks/
for _f in $CONFDIR/destdir-checks/*.sh; do
    if [ -x "$_f" ]; then
	info "  destdir-checks: $(basename $_f .sh)"
        cd $D
        . $_f
    fi
done

# S strip
info "  strip ..."
cd $D
find . -type f | xargs file | egrep 'ELF.*(executable|shared object)' 2>/dev/null | cut -f1 -d: | while read f; do
    strip --strip-unneeded "$f" 2>/dev/null || true
done

# P package
info "  package ..."
cd $D
[ -x $CONFDIR/makepkg.sh ] && $CONFDIR/makepkg.sh $PKGDIR/$PF

# OK
info "  OK"

