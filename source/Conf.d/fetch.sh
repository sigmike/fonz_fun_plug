#!/bin/sh

usage()
{
	echo "Usage: $(basename $0) [-d distfiles-directory] uri..."
	exit 1
}

die()
{
	cat <<EOF
ERROR: $@
EOF
	exit 1
}


# default destination directory
D=$(pwd)


# parse options
[ $# -eq 0 ] && usage
_opts=$(getopt hd: "$@") || usage
eval set -- "$_opts"
while true; do
	case "$1" in
		-d)
			D="${2%/}"
			shift 2
			;;
		-h)
			usage
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


# specific fetch functions

fetch_wget()
{
	_cmd="wget -O '$2' '$1'"
	echo "$_cmd"
	eval $_cmd
}

fetch_svn()
{
	_cmd="cd '$(dirname $2)'; svn co '$1' '$(basename $2)'"
	echo "$_cmd"
	eval $_cmd
}

fetch_cvs()
{
	module=$(basename $2)
	cvsroot=$(echo $1 | sed -e 's@^cvs:@@' -e "s@/$module\$@@")
	_cmd="cd '$(dirname $2)'; CVS_RSH=ssh cvs -d '$cvsroot' checkout '$module'"
	echo $_cmd
	eval $_cmd
}

# one by one
while [ $# -gt 0 ]; do

	uri="$1"
	f=$(echo "$uri" | sed -e 's@.*/@@')
	shift

	if [ -e "$D/$f" ]; then
		echo "* $f exists"
		continue
	fi

	case "$uri" in
		http:* | https:* | ftp:*)
			_cmd="fetch_wget"
			;;
		svn:*)
			_cmd="fetch_svn"
			;;
		cvs:*)
			_cmd="fetch_cvs"
			;;
		*)
			die "Unknown protocol: $uri"
			;;
	esac
	echo "* $f"
	mkdir -p $D
	eval $_cmd '$uri' '$D/$f' || die "Download of '$uri' failed"
done


