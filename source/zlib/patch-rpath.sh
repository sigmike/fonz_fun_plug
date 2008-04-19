sed -i "/Linux.* LDSHARED=/ s@ -shared @&${LDFLAGS_RPATH} @" configure

