#!/ffp/bin/sh

# PROVIDES: portmap
# BEFORE: LOGIN
# REQUIRE: SERVERS

. /ffp/etc/ffp.subr

name="portmap"
command="/ffp/sbin/rpc.portmap"

run_rc_command "$1"

