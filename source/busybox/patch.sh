        # set LINE_LEN for comm to a more realistic limit
        sed -i \
                -e "/#define LINE_LEN/ s@LINE_LEN.*@LINE_LEN 1000@" \
                coreutils/comm.c
