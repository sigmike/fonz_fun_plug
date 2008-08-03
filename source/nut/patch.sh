sed -i '/^bcmxcp_.*LDADD/ s@$@ -lm@' drivers/Makefile.in

