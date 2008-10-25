cd $X/files/ffp/etc
tar cf - --exclude=\*~ * | tar xf - -C $D/ffp/etc

# telnetd with login
cd $D/ffp
sed -i 's/^telnetd_flags/#&/' start/telnetd.sh

# make it look like a real rootfs
cd $D
ln -s ffp/bin bin
ln -s ffp/sbin sbin
ln -s ffp/lib lib
ln -s ffp/etc etc
ln -s ffp usr
mkdir -p proc sys mnt tmp
chmod 01777 tmp
mkdir -p var/log var/run

# more...
cd $D/ffp
ln -s /proc/mounts etc/mtab

# remove stuff
cd $D/ffp
rm -rf etc/examples
rm -rf include
rm -f lib/*.a lib/*.la
rm -rf share/doc share/info share/man
rm -rf share/tabset

# strip down terminfo
cd $D/ffp/share/terminfo
rm -rf [1-9] [A-Z] [a-k] m [o-t] w z

# enable start scripts
cd $D/ffp/start
chmod a+x syslogd.sh telnetd.sh

# want /bin/sh -> bash
cd $D/bin
rm -f sh
ln -s bash sh

# need /init in initramfs
cd $D
ln -s ffp/sbin/init init

