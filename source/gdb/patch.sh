# CBLFS:

# Apply a sed substitution that will suppress the installation of 
# libiberty.a. The version of libiberty.a that was provided by 
# Binutils during the initial CLFS build will be retained:

sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in

