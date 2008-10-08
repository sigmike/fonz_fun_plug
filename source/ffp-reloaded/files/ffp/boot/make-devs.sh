#!/ffp/bin/sh

die()
{
    cat >&2 <<EOF
ERROR: $@
EOF
    exit 1
}

[ $# -ne 1 ] && die "Usage: $0 /path/to/dev"
mkdir -p $1 || die "$1: mkdir failed"
cd $1 || die "$1: cd failed"

# 
set -x

mknod -m 0600 console c 5   1
mknod -m 0666 null    c 1   3
mknod -m 0660 ttyS0   c 4   64
mknod -m 0660 zero    c 1   5

ln -sf /proc/self/fd	fd
ln -sf /proc/self/fd/0	stdin
ln -sf /proc/self/fd/1	stdout
ln -sf /proc/self/fd/2	stderr
ln -sf /proc/kcore	core

