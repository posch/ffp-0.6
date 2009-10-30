_unpack $P
cd $P

# sed from DIY
sed -i \
        -e "s,X)/man,X)$mandir,g" \
        -e '/ln .*PREFIX/s,$(PREFIX)/bin/,,' \
        Makefile

# use LDFLAGS from environment
sed -i 's@^LDFLAGS=.*@#&@' Makefile
sed -i 's@ -o@ $(LDFLAGS)&@' Makefile-libbz2_so 

export LDFLAGS="$FFP_LDFLAGS"

make -f Makefile-libbz2_so
make clean
make

make PREFIX=$D/ffp install
cp bzip2-shared $D/ffp/bin/bzip2
cp -a libbz2.so* $D/ffp/lib
ln -s $(basename $(find $D/ffp/lib -type f -name libbz2.so.\*)) $D/ffp/lib/libbz2.so

_doc CHANGES LICENSE README bzip2.txt manual.html
_descr
_makepkg

