#!/ffp/bin/sh

# PROVIDE: syslogd klogd
# BEFORE: SERVERS
# REQUIRE: rcS

. /ffp/etc/ffp.subr

name="syslogd"
klogd_flags="-c 3"
start_cmd="syslogd_start"
stop_cmd="syslogd_stop"
status_cmd="syslogd_status"

syslogd_start()
{
    proc_start /ffp/sbin/syslogd /ffp/sbin/klogd
}

syslogd_stop()
{
    proc_stop syslogd klogd
}

syslogd_status()
{
    proc_status syslogd klogd
}

run_rc_command "$1"
