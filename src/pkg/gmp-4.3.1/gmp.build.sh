_unpack $P
mkdir build
cd build

LDFLAGS="$FFP_LDFLAGS" \
../$P/configure \
    --build=$GNU_BUILD --host=$GNU_HOST \
    --prefix=/ffp \
    --mandir=$mandir --infodir=$infodir \
    --disable-nls \
    --enable-shared --with-gnu-ld --enable-static \
    --enable-fft \
    --enable-cxx \
    --enable-mpbsd

make
make DESTDIR=$D install

cd ../$P
_doc AUTHORS COPYING* NEWS README
_descr
_makepkg

