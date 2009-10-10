make R=$D install

cd $D

# I don't think we need these. Also, they err on start of radiusd with
# rlm....a is not an ELF file
rm -f ffp/lib/rlm*a

# fix bootstrap script to use correct interpreter and path
sed -i '1 s,.*,#!/ffp/bin/sh\nexport PATH=/ffp/sbin:/ffp/bin\n,' ffp/etc/raddb/certs/bootstrap

# don't overwrite config files, but install to examples/
mkdir -p ffp/etc/examples
mv ffp/etc/raddb ffp/etc/examples


