# i don't think /$prefix/share is the correct place for slimserver.

# remove all arch-specific files
rm -rvf CPAN/arch/*

# remove duplicate perl modules
P5=$CPREFIX/lib/perl5
cd CPAN
#$X/clean-cpan.sh $P5/* | $SHELL
$X/clean-cpan.sh $P5/vendor_perl/* $P5/vendor_perl/*/* | $SHELL
cd ..

# fix interpreters
PERL=$CPREFIX/bin/perl
for f in $(find -name \*.pl); do
    sed -i "/^#!/ s@/usr/bin/perl@$PERL@" $f
done

# build local perl modules
mkdir -p CPAN/arch  # so build-perl-modules stops moaning
# patch script to
# - make it stop asking
# - use correct perl interpreter
# - use a different directory to download and build packages
sed -i.orig \
    -e '/STDIN/ s@^@# @' \
    -e "s@/usr/bin/perl@$PERL@" \
    -e "/\$downloadPath ||=/ s@'\.'@'$TMPDIR'@" \
    Bin/build-perl-modules.pl

$PERL ./Bin/build-perl-modules.pl JSON::XS YAML::Syck

#    AutoXS::Header Class::XSAccessor Class::XSAccessor::Array

# remove arch-specific binaries
rm -rf Bin/MSWin* Bin/i386* Bin/darwin* Bin/powerpc*

