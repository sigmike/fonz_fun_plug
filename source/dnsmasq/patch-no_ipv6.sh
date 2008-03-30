    sed -i \
        -e 's,^CFLAGS =.*,& -DNO_IPV6,' \
        bld/Makefile

