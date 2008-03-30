    # fixes taken from buildroot/packages/ntp/ntp.mk
    sed -i.bak "s,^#if.*__GLIBC__.*_BSD_SOURCE.*$$,#if 0," ntpd/refclock_pcf.c
    sed -i.bak '/[[:space:](]index[[:space:]]*(/s/[[:space:]]*index[[:space:]]*(/ strchr(/g' libisc/*.c arlib/sample.c
    sed -i.bak '/[[:space:](]rindex[[:space:]]*(/s/[[:space:]]*rindex[[:space:]]*(/ strrchr(/g' ntpd/*.c
    #$(SED) 's/\(^#[[:space:]]*include[[:space:]]*<sys\/var.h>\)/\/\/ \1/' $(NTP_DIR)/util/tickadj.c

