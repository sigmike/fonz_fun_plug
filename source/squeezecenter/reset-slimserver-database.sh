#!/ffp/bin/sh

if [ -d /ffp/var/mysql/slimserver ]; then
	mysql -u root <<EOF
drop database slimserver;
EOF
fi

# reset slimserver database
mysql -u root <<EOF
create database slimserver;
grant all on slimserver.* to 'slimserver'@'localhost' identified by '';
flush privileges;
EOF


