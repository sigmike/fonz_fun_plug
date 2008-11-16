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
	if pidof slimserver.pl >/dev/null 2>/dev/null; then
		echo "Already running"
	else

		# create slimserver database
		if [ ! -d /ffp/var/mysql/slimserver ]; then
			/ffp/sbin/reset-slimserver-database.sh
		fi
    
		cd $(dirname $command)
		# this su command uses busybox-specific syntax!
		su nobody -p -c "nohup ./$(basename $command) $slimserver_flags >/dev/null 2>&1 &"
	fi
}

slimserver_stop()
{
	if [ -r /ffp/lib/squeezecenter/Logs/slimserver.pid ]; then
		kill $(cat /ffp/lib/squeezecenter/Logs/slimserver.pid)
	fi
	killall slimserver.pl 2>/dev/null
}

run_rc_command "$1"

