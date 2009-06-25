
# fix hardcoded paths in updatedb:
#  interpreter -> /ffp/bin/sh
#  temp        -> /ffp/tmp

sed -i  -e '1 s,/bin/sh,/ffp&,' \
	-e 's,/usr/,/ffp/,' \
	locate/updatedb.sh

