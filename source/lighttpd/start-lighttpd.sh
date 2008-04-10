#!/ffp/bin/sh

# PROVIDE: lighttpd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="lighttpd"
command="/ffp/sbin/lighttpd"
lighttpd_flags="-f /ffp/etc/lighttpd.conf"
required_files="/ffp/etc/lighttpd.conf"

run_rc_command "$1"
