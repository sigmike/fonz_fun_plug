
# adjust DEFAULT_DBSOURCE
# we use a separate mysqld
sed -i \
    -e "/^my \$DEFAULT_DBSOURCE/ s@= .*@= 'dbi:mysql:database=slimserver';@" \
    Slim/Utils/Prefs.pm
