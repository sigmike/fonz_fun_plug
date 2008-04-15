#!/ffp/bin/sh

# PROVIDE: kickwebs
# REQUIRE: LOGIN
# BEFORE: lighttpd

. /ffp/etc/ffp.subr
name="kickwebs"
start_cmd="kickwebs_start"
stop_cmd=:

kickwebs_start()
{
	echo "Kicking webs ..."
	killall webs
}

run_rc_command "$1"

