#!/ffp/bin/sh

# PROVIDES: rsyncd
# REQUIRES: LOGIN

. /ffp/etc/ffp.subr

name="rsyncd"
command="/ffp/bin/rsync"
rsync_flags="--daemon --config=/ffp/etc/rsyncd.conf"
required_files="/ffp/etc/rsyncd.conf"

run_rc_command "$1"

