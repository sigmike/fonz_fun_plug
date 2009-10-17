
# Location and format changed in 7.4.0
# adjust DEFAULT_DBSOURCE
# we use a separate mysqld
#    -e "/^my \$DEFAULT_DBSOURCE/ s@= .*@= 'dbi:mysql:database=slimserver';@" \
sed -i \
    -e "/default_dbsource/ s,'.*','dbi:mysql:database=slimserver'," \
    Slim/Utils/MySQLHelper.pm


# Search for mysqld doesn't include /ffp/libexec, but mysqld won't
# start correctly, anyway, so don't touch this.
 
# adjust findbin paths
#sed -i '/PATH/ s,/usr/libexec ,/ffp/libexec &,' \
#    Slim/Utils/OS/Unix.pm

