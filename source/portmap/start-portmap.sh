#!/ffp/bin/sh

# PROVIDE: portmap
# REQUIRE: SERVERS
# BEFORE: LOGIN

. /ffp/etc/ffp.subr

name="portmap"
command="/ffp/sbin/rpc.portmap"

run_rc_command "$1"

