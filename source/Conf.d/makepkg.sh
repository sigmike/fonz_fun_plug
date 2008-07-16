#!/bin/sh
die()
{
    cat >&2 <<EOF
$@
EOF
    exit 1
}

[ $# -eq 1 ] || die "Usage: $0 <package-file>"
[ -e "$1" ] && rm -f "$1"
mkdir -p $(dirname "$1")
tar cf - --exclude=\*~ . | gzip -c -9 >$1.tgz
