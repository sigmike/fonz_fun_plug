#!/ffp/bin/sh

# PROVIDE: shells
# BEFORE: SERVERS

. /ffp/etc/ffp.subr

name="shells"
start_cmd="shells_start"
stop_cmd=:

shells_start()
{
	# add ffp shells to /etc/shells
	for _shell in /ffp/bin/sh /ffp/bin/bash; do
		if ! grep $_shell /etc/shells >/dev/null; then
			echo $_shell >>/etc/shells
		fi
	done

	# and create some essential symlinks
	if [ -x /ffp/bin/bash ]; then
		ln -s /ffp/bin/bash /bin/bash 2>/dev/null
	fi
	if [ -x /ffp/bin/perl ]; then
		ln -s /ffp/bin/perl /usr/bin/perl 2>/dev/null
	fi
}

run_rc_command "$1"

