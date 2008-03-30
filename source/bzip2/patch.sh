    # sed from DIY
    sed -i \
        -e 's,X)/man,X)/share/man,g' \
        -e '/ln .*PREFIX/s,$(PREFIX)/bin/,,' \
        Makefile

