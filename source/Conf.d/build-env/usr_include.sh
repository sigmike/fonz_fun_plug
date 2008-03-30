#!/bin/sh

check_required_dirs "$CPREFIX/include"

# link /usr/include -> $CPREFIX/include
[ -d /usr/include ] || ln -s $CPREFIX/include /usr/include
