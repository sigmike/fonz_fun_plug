export DISTCC_DIR=$CONFDIR/distcc
#export DISTCC_VERBOSE=1

export CC="distcc gcc"
export CXX="distcc g++"

#export MAKEFLAGS="$MAKEFLAGS CC=${CC} CXX=${CXX}"

