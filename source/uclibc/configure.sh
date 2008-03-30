config_enable() {
    sed -i "s,^# $1 is not set,$1=y," .config
}
config_disable() {
    sed -i "s,$1=y,# $1 is not set," .config
}


    # Set paths
    cat $CONFIGDIR/$P.config >.config
    sed -i \
        -e "/^KERNEL_HEADERS/s:=.*:=\"$CPREFIX/include\":" \
        -e "/^SHARED_LIB_LOADER_PREFIX/s:=.*:=\"$CPREFIX/lib\":" \
        -e "/^RUNTIME_PREFIX/s:=.*:=\"$CPREFIX\":" \
        -e "/^DEVEL_PREFIX/s:=.*:=\"$CPREFIX\":" \
        -e "/^CROSS_COMPILER_PREFIX/s:=.*:=\"\":" \
        .config


    #   Target ABI
    config_disable      "CONFIG_ARM_EABI"
    config_enable       "CONFIG_ARM_OABI"

    #   Soft-Float
    config_disable      "UCLIBC_HAS_FPU"
    config_enable       "UCLIBC_HAS_SOFT_FLOAT"

    make oldconfig

