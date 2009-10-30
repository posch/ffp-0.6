_unpack $P
mkdir build
cd build

LDFLAGS="$FFP_LDFLAGS" \
../$P/configure \
    --build=$GNU_BUILD --host=$GNU_HOST \
    --with-gmp=$SYSROOT/ffp \
    --prefix=/ffp \
    --mandir=$mandir --infodir=$infodir \
    --disable-nls \
    --enable-shared --enable-static

make
make DESTDIR=$D install

cd ../$P
_doc AUTHORS BUGS COPYING* FAQ.html INSTALL NEWS README TODO VERSION
_descr
_makepkg

