_unpack $P
cd $P

for p in $X/patches/*.patch; do
	patch -p1 -i $p
done

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls
    
make
make DESTDIR=$D install
    
_doc AUTHORS COPYING INSTALL NEWS README THANKS TODO
_descr
_makepkg

