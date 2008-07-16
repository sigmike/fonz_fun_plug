#!/ffp/bin/sh

# PROVIDE: samba
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="samba"
start_cmd="samba_start"
stop_cmd="samba_stop"
status_cmd="samba_status"

smbd_flags="-D"
nmbd_flags="-D"

required_files="/ffp/etc/samba/smb.conf"

samba_start()
{
	proc_start /ffp/sbin/smbd
	proc_start /ffp/sbin/nmbd
}

samba_stop()
{
	proc_stop smbd
	proc_stop nmbd
}

samba_status()
{
	proc_status smbd
	proc_status nmbd
}

run_rc_command "$1"

