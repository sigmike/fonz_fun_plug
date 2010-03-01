# i don't think /$prefix/share is the correct place for slimserver.

# remove all arch-specific files
rm -rvf CPAN/arch/*

# remove duplicate perl modules
P5=$CPREFIX/lib/perl5
cd CPAN
#$X/clean-cpan.sh $P5/* | $SHELL
$X/clean-cpan.sh $P5/5.* $P5/5.*/*-multi $P5/vendor_perl/* $P5/vendor_perl/*/* | $SHELL
cd ..

# fix interpreters
PERL=$CPREFIX/bin/perl
for f in $(find -name \*.pl); do
    sed -i "/^#!/ s@/usr/bin/perl@$PERL@" $f
done

# remove arch-specific binaries
rm -rf Bin/MSWin* Bin/i386* Bin/darwin* Bin/powerpc*

