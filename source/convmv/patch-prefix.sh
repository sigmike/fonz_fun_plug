sed -i "/^PREFIX/ s@=.*@=$CPREFIX@" Makefile

sed -i "/^#!/ s@/usr/bin/perl@$CPREFIX/bin/perl@" convmv

