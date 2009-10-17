#!/ffp/bin/sh

# PROVIDE: ffp-admin
# REQUIRE: LOGIN

. /ffp/etc/ffp.subr

httpd_port=90

name="httpd"
command="/ffp/sbin/$name"
required_files="/ffp/etc/ffp-admin.conf"
httpd_flags="-p $httpd_port -c /ffp/etc/ffp-admin.conf"

run_rc_command "$1"

