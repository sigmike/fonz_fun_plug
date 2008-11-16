#!/bin/bash
cd $D/ffp

# custom files
install -m 0755 -o root -g root $X/fun_plug.local etc/
#install -m 0755 -o root -g root $X/reset-slimserver-database.sh sbin
install -m 0755 -o root -g root $X/start-mysqld.sh start/mysqld.sh

# start scripts
#chmod a-x start/telnetd.sh
chmod a+x start/mysqld.sh start/slimserver.sh

# mysql config
cat $X/my.cnf >etc/my.cnf

# remove header files and static libs
rm -rf include
rm -f $(find lib -name \*.a)

# remove documentation
rm -rf share/{doc,info,man}

# don't need terminfo database
rm -rf share/{tabset,terminfo}

# remove misc stuff
rm -rf share/{et,ss}

# no package database in this package
rm -rf var/packages

# leave a version number
date >etc/squeezecenter-funplug-version

# add uninstall script
mkdir -p sbin
install -m 0755 -o root -g root $X/uninstall-ffp.sh sbin

# add web interface
install -m 0755 -o root -g root $X/start-ffp-admin.sh start/ffp-admin.sh
install -m 0644 -o root -g root $X/ffp-admin.conf etc
mkdir -p share/ffp-admin
cp -r $X/htdocs share/ffp-admin
rm -f share/ffp-admin/htdocs/*~
chown -R root:root share/ffp-admin

# disable telnet
chmod a-x start/telnetd.sh

