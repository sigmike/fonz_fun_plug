#!/ffp/bin/sh

# PROVIDE: dropbear
# REQUIRES: LOGIN

. /ffp/etc/ffp.subr

name="dropbear"
command="/ffp/sbin/dropbear"
dropbear_confdir="/ffp/etc/dropbear"
dropbear_rsa_host_key="$dropbear_confdir/dropbear_rsa_host_key"
dropbear_dsa_host_key="$dropbear_confdir/dropbear_dsa_host_key"
dropbear_flags="-r $dropbear_rsa_host_key -d $dropbear_dsa_host_key -l /ffp/bin/sh"
start_cmd="dropbear_start"

dropbear_keygen()
{
	mkdir -p $dropbear_confdir
	if [ -f $dropbear_rsa_host_key ]; then
		echo "$dropbear_rsa_host_key exists."
	else
		/ffp/bin/dropbearkey -t rsa -f $dropbear_rsa_host_key
	fi

	if [ -f $dropbear_dsa_host_key ]; then
		echo "$dropbear_dsa_host_key exists."
	else
		/ffp/bin/dropbearkey -t dss -f $dropbear_dsa_host_key
	fi
}

dropbear_start()
{
    if [ ! -f $dropbear_rsa_host_key -o ! -f $dropbear_dsa_host_key ]; then
        dropbear_keygen
    fi

    proc_start $command >/dev/null 2>/dev/null </dev/null &
}

run_rc_command "$1"
