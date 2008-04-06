
#sed -i "/define LOGINDEFS/ s@/etc@$CSYSCONFDIR@" lib/getdef.c
sed -i "s@/etc/login.defs@$CPREFIX&@" $(grep -rl /etc/login.defs *)

