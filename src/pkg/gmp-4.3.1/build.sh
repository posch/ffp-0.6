unpack $P.tar.bz2
cd $P
mpatch -p1 $X/$P-*.patch
cd ..

mkdir build
cd build

CFLAGS="$FFP_CFLAGS" \
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

if [ "$GNU_BUILD" != "$GNU_HOST" ]; then
	rm -f $D/ffp/lib/*.la
fi

cd ../$P
install_doc AUTHORS COPYING* NEWS README

