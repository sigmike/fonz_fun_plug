
#sed -i 's@-o libjpeg.la @&$(LDFLAGS) @' makefile.cfg

# dirty hack
sed -i "s@ -shared @&${LDFLAGS_RPATH} @" ltconfig

