#!/ffp/bin/sh

# PROVIDE: btpd
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

name="btpd"
command="/ffp/bin/$name"
btpd_flags="-d /mnt/HD_a2/tmp/ --empty-start --logfile /mnt/HD_a2/tmp/btpd.log"

run_rc_command "$1"

