    # The following sed causes DynaLoader.a  to be built with -fPIC so it can be linked into a shared library later:
    sed -i \
        -e "s@pldlflags=''@pldlflags=\"\$cccdlflags\"@g" \
        -e "s@static_target='static'@static_target='static_pic'@g" \
        Makefile.SH

