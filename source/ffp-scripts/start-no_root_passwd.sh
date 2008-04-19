#!/ffp/bin/sh

# PROVIDE: no_root_passwd
# BEFORE: SERVERS
# REQUIRE: passwd

. /ffp/etc/ffp.subr

name="no_root_passwd"
start_cmd="no_root_passwd_start"
stop_cmd=:

no_root_passwd_start()
{
	usermod -p '' root
}

run_rc_command "$1"

