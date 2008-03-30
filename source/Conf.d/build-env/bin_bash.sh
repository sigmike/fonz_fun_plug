#!/bin/sh

check_required_files $CPREFIX/bin/bash

# /bin/bash
[ -e /bin/bash ] || ln -s $CPREFIX/bin/bash /bin/bash

# relink /bin/sh -> $bash, keep original /bin/sh as /bin/sh.orig
if [ "$(basename $(readlink -f /bin/sh))" != "bash" ]; then
	mv /bin/sh /bin/sh.orig
	ln -s $bash /bin/sh
fi

