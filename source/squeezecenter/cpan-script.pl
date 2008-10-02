#!/ffp/bin/perl -w

use CPAN;

for $mod (qw(Compress::Zlib Digest::SHA1)) {
    CPAN::Shell->install($mod)
}

