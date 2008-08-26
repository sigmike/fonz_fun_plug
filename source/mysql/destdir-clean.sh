# remove testsuite
rm -rf $D$CPREFIX/mysql-test

# add some lib links
(
    cd $D$CPREFIX/lib
    ln -sf mysql/libmysqlclient.so .
    ln -sf mysql/libmysqlclient.so.15 .
    ln -sf mysql/libmysqlclient_r.so .
    ln -sf mysql/libmysqlclient_r.so.15 .
)

# socket 
mkdir -p $D$CPREFIX/var/run/mysql

# example config
(
    cd support-files
    mkdir -p $D$CPREFIX/etc/examples/mysql
    cp my*.cnf $D$CPREFIX/etc/examples/mysql
)
