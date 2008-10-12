#!/ffp/bin/sh

# PROVIDE: slimserver
# REQUIRE: LOGIN mysqld

. /ffp/etc/ffp.subr

name="slimserver"
command="/ffp/lib/squeezecenter/slimserver.pl"
slimserver_flags="--prefsdir /ffp/etc/squeezecenter --pidfile /ffp/lib/squeezecenter/Logs/slimserver.pid"

start_cmd="slimserver_start"
stop_cmd="slimserver_stop"

slimserver_start()
{
    # slimserver user and group
    if ! grep -wq slimserver /etc/group; then
	echo "Adding slimserver group"
	groupadd -g 612 slimserver
    fi
    if ! grep -wq slimserver /etc/passwd; then
	echo "Adding slimserver user"
	useradd -u 612 -d /no/where -g slimserver -s /bin/false slimserver
    fi

    cd $(dirname $command)

    # this su command uses busybox-specific syntax!
    su slimserver -p -c "nohup ./$(basename $command) $slimserver_flags >/dev/null 2>&1 &"
}

slimserver_stop()
{
    kill $(cat /ffp/lib/squeezecenter/Logs/slimserver.pid)
}

run_rc_command "$1"

