autoreconf --install

# add -lm to bcmxcp
sed -i.orig '/^bcmxcp_.*LDADD/ s,$, -lm,' drivers/Makefile.in

./configure ${configure_args}

