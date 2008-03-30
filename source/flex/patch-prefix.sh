    # Make sure that Flex doesn't try to include headers from
    # /usr/include.
    sed -i \
        -e "s/-I@includedir@//g" \
        Makefile.in

