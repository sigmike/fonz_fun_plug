#!/bin/bash

M=MANIFEST.txt

rm -f $M
>$M

for f in *.tgz; do

    echo $f

    cat >>$M <<EOF
++========================================
||
||   Package:  $(basename $f)
||
++========================================
EOF

    tar tzvf $f >>$M
done

