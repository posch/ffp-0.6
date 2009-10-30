BINUTILS_EXTRA_CONFIG="--with-float=soft"

_unpack $P
cd $P
for p in $X/patches/*.patch; do
	patch -p1 -i $p
done
mkdir ../build
cd ../build

LDFLAGS="$FFP_LDFLAGS" \
../$P/configure \
    --build=$GNU_BUILD --host=$GNU_HOST --target=$GNU_TARGET \
    --prefix=/ffp \
    --with-lib-path=/ffp/lib \
    --disable-multilib \
    --enable-shared \
    --infodir=$infodir --mandir=$mandir \
    --disable-nls \
    --disable-werror \
    $BINUTILS_EXTRA_CONFIG

make tooldir=/ffp
make tooldir=/ffp DESTDIR=$D install

cd ../$P
_doc COPYING* README
_descr
_makepkg

