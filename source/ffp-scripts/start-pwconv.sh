#!/ffp/bin/sh

# PROVIDE: pwconv
# REQUIRE: passwd
# BEFORE: SERVERS

. /ffp/etc/ffp.subr

name="pwconv"
start_cmd="pwconv_start"
stop_cmd=:

pwconv_start()
{
	# this will create missing entries in /etc/shadow
	# and also solve the 'must change password' problem
	echo "Running pwconv ..."
	pwconv
}

run_rc_command "$1"

