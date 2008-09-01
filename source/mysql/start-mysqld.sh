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
	/ffp/bin/mysqld_safe $mysqld_flags </dev/null &
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
