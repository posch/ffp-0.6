set -e
_unpack $P
cd $P

for p in $X/patches/*.patch; do
	patch -p1 -i $p
done

sed -i "s@^SHLIB_LIBS=@&-lncursesw ${FFP_LDFLAGS}@" support/shobj-conf

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls

make
make DESTDIR=$D install

_doc CHANGELOG CHANGES COPYING INSTALL MANIFEST README USAGE
_descr
_makepkg

