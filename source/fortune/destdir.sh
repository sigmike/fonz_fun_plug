mkdir -p $D/ffp/bin
install -m 0755 fortune $D/ffp/bin

mkdir -p $D/ffp/share/games/fortunes
for f in $X/datfiles/*.gz; do
    n=$(basename $f .gz)
    gzip -cd $f >$D/ffp/share/games/fortunes/$n
done

