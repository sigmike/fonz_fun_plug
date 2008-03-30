    # make uClibc copy headers (and not create symlinks)
    sed -i -e 's/$(LN) -fs/cp/g' Makefile
    for file in $(find libc/sysdeps/linux -name Makefile); do
        sed -i \
            -e 's/$(LN) -fs/cp/g' -e 's@../libc/@$(TOPDIR)libc/@g' \
            $file
    done

    #     fix install_utils paths
    sed -i.bak 's,usr/,,' utils/Makefile.in

