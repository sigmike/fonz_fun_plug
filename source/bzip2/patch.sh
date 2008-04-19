    # sed from DIY
    sed -i \
        -e 's,X)/man,X)/share/man,g' \
        -e '/ln .*PREFIX/s,$(PREFIX)/bin/,,' \
        Makefile

# use LDFLAGS from environment
sed -i 's@^LDFLAGS=.*@#&@' Makefile
sed -i 's@ -o@ $(LDFLAGS)&@' Makefile-libbz2_so 

