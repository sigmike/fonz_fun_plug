#!/ffp/bin/sh

# PROVIDE: btpd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="btpd"
command="/ffp/bin/$name"
btpd_flags="--empty-start"

run_rc_command "$1"

