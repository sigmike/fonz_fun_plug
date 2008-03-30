    mkdir -p $D$CSYSCONFDIR
    make DESTDIR=$D install

    cat >$D$CSYSCONFDIR/vimrc <<EOF
set nocompatible
set backspace=2
syntax on
EOF

