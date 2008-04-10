#!/ffp/bin/sh

# PROVIDE: inetd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="inetd"
command="/ffp/sbin/$name"
required_files="/ffp/etc/inetd.conf"
inetd_flags="/ffp/etc/inetd.conf"

run_rc_command "$1"

