#!/ffp/bin/sh

# PROVIDES: ntpd
# REQUIRES: SERVERS
# BEFORE: LOGIN

. /ffp/etc/ffp.subr

name="ntpd"
command="/ffp/bin/ntpd"
ntpd_flags="-g -f /ffp/etc/ntp.drift"
required_files="/ffp/etc/ntp.conf"
start_cmd="ntpd_start"

ntpd_start()
{
	# fix /etc/services
	if ! grep -w ntp /etc/services >/dev/null; then
		echo "ntp 123/udp" >>/etc/services
	fi

	proc_start $command            
}

run_rc_command "$1"

