#!/bin/bash
cd $D/ffp


# TODO:
# install fun_plug.local
# - user/group: slimserver
# create mysql database


# start scripts
chmod a-x start/telnetd.sh
chmod a+x start/mysqld.sh slimserver.sh

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


