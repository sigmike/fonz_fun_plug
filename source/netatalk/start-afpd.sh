#!/ffp/bin/sh

# PROVIDE: afpd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="afpd"
command="/ffp/sbin/$name"

run_rc_command "$1"

