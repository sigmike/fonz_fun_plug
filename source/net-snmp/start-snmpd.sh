#!/ffp/bin/sh

# PROVIDE: snmpd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

config_file=/ffp/etc/snmp/snmpd.conf
required_files="$config_file"
name="snmpd"
command="/ffp/sbin/$name"
snmpd_flags="-A -p /ffp/var/run/snmpd -a -c $config_file"

run_rc_command "$1"

