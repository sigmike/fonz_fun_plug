#!/ffp/bin/sh

export PATH=/ffp/sbin:/ffp/bin:/usr/sbin:/sbin:/usr/bin:/bin

# Be sure user knows what he's calling for.
if [ "$1" != "now" ]; then
	cat <<EOF
This script will uninstall ffp. If you want to do this, run
  $(basename $0) now
EOF
	exit 1
fi

# This will stop all services and uninstall ffp. Because we don't
# want to be interrupted, we write an uninstall script to /tmp
# and run it using nohup.

script="/tmp/do-uninstall-ffp.sh"
ffp="$(readlink -f /ffp)"

rm -f $script
cat >$script <<EOF
#!/bin/sh
set -x

if [ -x /ffp/etc/rc ]; then
	echo "Stopping ffp: /ffp/etc/rc stop"
	/ffp/etc/rc stop
fi

sleep 30
sync

if [ -h /ffp ]; then
	echo "Removing files ..."
	rm -rf $ffp /ffp /mnt/HD_a2/ffp.log /mnt/HD_a2/fun_plug
fi

echo "OK."
EOF

chmod a+x $script
cd /tmp
/ffp/bin/nohup $script >$script.log 2>&1 </dev/null &

