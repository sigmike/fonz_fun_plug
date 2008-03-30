#!/ffp/bin/sh

# PROVIDES: mediatomb
# REQUIRES: LOGIN

. /ffp/etc/ffp.subr

media_dir="/mnt/HD_a2/home/media"

name="mediatomb"
command="/ffp/bin/$name"
mediatomb_flags="-d --interface egiga0  --home /ffp/var --cfgdir mediatomb --add $media_dir"

run_rc_command "$1"

