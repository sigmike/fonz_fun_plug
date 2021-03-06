#!/ffp/bin/sh

# PROVIDE: mysqld
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="mysqld"
start_cmd="mysqld_start"
stop_cmd="mysqld_stop"
status_cmd="mysqld_status"

mysqld_flags="--skip-networking --user=root"

mysqld_start()
{
	if pidof mysqld >/dev/null 2>/dev/null; then
		echo "Already running"
	else
		/ffp/bin/mysqld_safe $mysqld_flags </dev/null &
		sleep 10 # mysql takes some time to start up
	fi
}

mysqld_stop()
{
    proc_stop mysqld
}

mysqld_status()
{
    proc_status mysqld
}

run_rc_command "$1"
