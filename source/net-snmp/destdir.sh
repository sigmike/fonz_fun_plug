make INSTALLDIRS=vendor DESTDIR=$D install

mkdir -p $D/ffp/var/lib/net-snmp
mkdir -p $D/ffp/etc/snmp

mkdir -p $D/ffp/etc/examples
cp EXAMPLE.conf $D/ffp/etc/examples/snmpd.conf

