
sed -i 's@ /sbin/ldconfig @ ldconfig @' prog/sensors/Module.mk

# RPATH
sed -i "/-soname/ s@ -Wl@ ${LDFLAGS_RPATH}&@" lib/Module.mk

