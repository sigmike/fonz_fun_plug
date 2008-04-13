#!/ffp/bin/sh

# PROVIDE: smartd
# REQUIRE: SERVERS
# BEFORE: LOGIN

. /ffp/etc/ffp.subr

name="smartd"
command="/ffp/sbin/$name"
required_files="/ffp/etc/smartd.conf"
smartd_flags="-c /ffp/etc/smartd.conf"

run_rc_command "$1"

