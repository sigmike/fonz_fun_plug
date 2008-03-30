#!/ffp/bin/sh

# PROVIDE: adjtimex
# BEFORE: SERVERS

. /ffp/etc/ffp.subr

name="adjtimex"
start_cmd="adjtimex_start"

# See also:
# http://forum.dsmg600.info/t572-Pulls-Wrong-Time.html

# Germany
timezone="CET-1CEST-2,M3.5.0/02:00:00,M10.5.0/03:00:00"
timeserv=de.pool.ntp.org

# clock ticks per day (perfect clock has 10000 ticks per day):
#  tick = (86400 + d)/8.64
# with d being drift in seconds per 24h
#  tick = 9965 for d = -300s
# ntpd still shows a drift of 334, though
tick=9965

adjtimex_start()
{
	echo "${timezone}" >/etc/TZ
	if [ -n "${tick}" ]; then
		adjtimex -t ${tick}
	fi
	/usr/sbin/sntp -r -P no ${timeserv}
	sleep 1
	/usr/sbin/rtc -w
}

run_rc_command "$1"    
