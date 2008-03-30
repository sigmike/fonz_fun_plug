#  /etc/profile, /etc/hosts
#   -e "/DEFAULT_HOSTS_FILE/ s@/etc/@$CSYSCONFDIR/@" \
sed -i \
	-e "/SYS_PROFILE/ s@/etc/@$CSYSCONFDIR/@" \
	pathnames.h.in
				    
#  /etc/inputrc
sed -i \
	-e "/SYS_INPUTRC/ s@/etc/@$CSYSCONFDIR/@" \
	lib/readline/rlconf.h

