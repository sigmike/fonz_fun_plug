make PREFIX=$D$CPREFIX install

cd $D$CPREFIX
cp $B/bzip2-shared bin/bzip2
cp -a $B/libbz2.so* lib
rm bin/bunzip2 bin/bzcat
ln -s bzip2 bin/bunzip2
ln -s bzip2 bin/bzcat

