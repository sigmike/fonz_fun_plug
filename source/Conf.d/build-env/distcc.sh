export DISTCC_DIR=$CONFDIR/distcc
#export DISTCC_VERBOSE=1
export CC=distcc

#export MAKEFLAGS="$MAKEFLAGS -j4"
export MAKEFLAGS="$MAKEFLAGS CC=${CC}"

