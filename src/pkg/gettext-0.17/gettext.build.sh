_unpack $P
cd $P

for p in $X/patches/*.patch; do
	patch -p1 -i $p
done

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir --docdir=$docdir/$P

make
make DESTDIR=$D install

_doc AUTHORS COPYING* DEPENDENCIES HACKING INSTALL NEWS README
_descr
_makepkg

