set -x

mod_list=(
    Compress::Zlib
    Digest::SHA1
)

for mod in ${mod_list[*]}; do
    perl -MCPAN -e 'CPAN::Shell->install("'$mod'")'
done
