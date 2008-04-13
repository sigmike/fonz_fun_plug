#!/ffp/bin/sh

# PROVIDE: passwd
# BEFORE: SERVERS
# REQUIRE: rcS

. /ffp/etc/ffp.subr

name="passwd"
start_cmd="passwd_start"
stop_cmd=:

passwd_start()
{
	# save unmodified passwd
	if [ ! -e /etc/passwd.orig ]; then	
		cp /etc/passwd /etc/passwd.orig
	fi
	
	# replace /bin/sh with /ffp/bin/sh
	sed -i 's@:/bin/sh$@:/ffp/bin/sh@' /etc/passwd

}

run_rc_command "$1"

