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
		echo "Saving /etc/passwd to /etc/passwd.orig ..."	
		cp /etc/passwd /etc/passwd.orig
	fi
	
	# replace /bin/sh with /ffp/bin/sh
	echo "Changing shells: /bin/sh -> /ffp/bin/sh ..."
	sed -i 's@:/bin/sh$@:/ffp/bin/sh@' /etc/passwd

	# next, create missing shadow entries
	echo "Updating /etc/shadow ..."
	pwconv
}

run_rc_command "$1"

