
bb_set() {
    sed -i "s,^$1=.*,$1=\"$2\"," .config
}
bb_enable() {
    sed -i "s,^# $1 is not set,$1=y," .config
}
bb_disable() {
    sed -i "s,^$1=y,# $1 is not set," .config
}
bb_remove() {
    sed -i \
        -e "/^$1=y/d" \
        -e "/^# $1 is not set/d" \
        .config
}



	# adjust config
        cp $CONFDIR/$P.config .config
        bb_set     "CONFIG_PREFIX" "$D$CPREFIX"
        bb_enable  "CONFIG_INSTALL_NO_USR"

        # don't install links now
        # we have busybox --install -s for that
        bb_enable  "CONFIG_INSTALL_APPLET_SYMLINKS"
        bb_disable "CONFIG_INSTALL_APPLET_HARDLINKS"
        bb_disable "CONFIG_INSTALL_APPLET_SCRIPT_WRAPPERS"
        bb_disable "CONFIG_INSTALL_APPLET_DONT"

yes '' | make oldconfig

