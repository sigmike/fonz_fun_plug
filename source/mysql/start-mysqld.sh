#!/ffp/bin/sh

# PROVIDE: mysqld
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="mysqld"
start_cmd="mysqld_start"
stop_cmd="mysqld_stop"
status_cmd="mysqld_status"

# Disable network connections. Comment out the following line if you
# need to allow connections over the network.
mysqld_skip="--skip-networking"

mysqld_flags="--datadir=/srv/mysql --pidfile=/ffp/var/run/mysql/mysql.pid $mysqld_skip"

mysqld_start()
{
    proc_start_bg /ffp/bin/mysqld_safe
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
