#!/ffp/bin/sh

# PROVIDE: telnetd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="telnetd"
command="/ffp/sbin/telnetd"
telnetd_flags="-l /ffp/bin/sh"
#telnetd_flags="-l /ffp/bin/login"

run_rc_command "$1"

