#!/ffp/bin/sh

# PROVIDE: rcS
# BEFORE: SERVERS

. /ffp/etc/ffp.subr

name="rcS"
start_cmd="rcS_start"
stop_cmd=:

rcS_start()
{
	# fixup firmware issues

	# /dev/random
	if [ ! -e /dev/random ]; then
		mknod /dev/random c 1 8
	fi

	# /dev/ptmx
	if [ ! -e /dev/ptmx ]; then
		mknod -m 0666 /dev/ptmx c 5 2
	fi

	# /dev/pts
	if [ ! -d /dev/pts ]; then
		mkdir /dev/pts
	fi
    
	# devpts mount
	mount | grep devpts 1>/dev/null 2>/dev/null \
		|| mount -t devpts devpts /dev/pts

	# writable /dev/tty and /dev/null
	chmod 0666 /dev/tty
	chmod 0666 /dev/null

    	# add essential groups
	if ! grep -w utmp /etc/group; then
		groupadd -g 22 utmp
	fi

	# create essential files
	mkdir -p /var/run /var/log
	touch /var/run/utmp /var/log/btmp /var/log/lastlog /var/log/wtmp
	chgrp utmp /var/run/utmp
	chmod 0664 /var/run/utmp /var/log/lastlog
}

run_rc_command "$1"

